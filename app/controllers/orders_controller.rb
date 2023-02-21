class OrdersController < ApplicationController
  before_action :prepare_new_order, only: [:stripe_create_payment]
  require 'stripe'
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
   
  def index
    products = Product.all
    @products_purchase = @cart
    @total_amount = session[:cart_hash]["products_price"].to_i
    @products_subscription = products.where(name:nil, name:nil)
    @address = UserAddress.select(:id,:shipping_address,:city,:state,:zipcode).last(5)
    @addr_hashs = []
    @address.each do |add|
      my_address = "#{add.shipping_address}, #{add.city}, #{add.state} - #{add.zipcode}"

    # p add.shipping_address
    # p my_address
    # @address_string << add.id
    # @address_string << my_address
       @addr_hashs << {id: add.id , address: my_address}
    end
    binding.pry
  end

  def submit
    if params[:payment_method].present?
      cash_on_delivery
    else
      if order_params[:payment_gateway] == "stripe"
        @product = prepare_new_order
        binding.pry
        @address = UserAddress.find(params[:address])
        @orders_products = @cart
        @total_amount = params[:user_orders][:total].to_i
        Stripes.execute(
                      user_order: @user_order, user: current_user,
                      product: @product, amount: @total_amount,
                      user_address: @address, coupon: @coupon
                      )
      end
    end
  ensure
    if  params[:payment_method] == "COD"
      return render 'orders/show'
      session[:cart_hash] = nil
    else
      binding.pry
      if @user_order&.save
        if @user_order.paid?
          product_price_lists = []
          products = Product.where(id: @cart.map(&:id))
          products.each do |product|
            @user_order.order_details.create(
                                            product_id: product.id,
                                            amount: product.price,
                                            quantity: product.quantity
                                            )
            total = (product.quantity)*(product.price)
            product_price_lists << total
            product.quantity = 1
            product.save
          end
          UserOrderMailer.with(order: @user_order,product: products, amount: @total_amount).new_order(current_user).deliver_now
          session[:cart] = nil
          # session[:cart_hash = nil]
          return render "orders/show"
        elsif @user_order.failed? && !@user_order.error_message.blank?
          return render html: @user_order.error_message
        end
      end
    end
  end
  
  def show
    @user_order = current_user.user_orders.last
  end

  private

  def prepare_new_order
    @address = current_user.user_addresses.last
    @user_order = UserOrder.new(order_params)
    @user_order.user_id = current_user.id
    @user_product = Product.find(params[:user_orders][:product_id])
    end
    
  def order_params
      params.require(:user_orders).permit(:token, :payment_gateway, :charge_id, :amount, :status)
  end

  def cash_on_delivery
    @user_order = UserOrder.new
    product_price_lists = []
    @total_amount = params[:final_price]
    products = Product.where(id: @cart.map(&:id))
    status = @user_order.set_order
    user_address = current_user.user_addresses.last
    if params[:coupon].present?
        @coupon = Coupon.find(params[:coupon])
        @user_order = UserOrder.create(user_id: current_user.id, order_status: status, user_address_id: user_address.id,coupon_id: @coupon.id)
    else
      @user_order = UserOrder.create(user_id: current_user.id, order_status: status, user_address_id: user_address.id)
    end
    products.each do |product|
      @user_order.order_details.create(product_id: product.id,amount: product.price,quantity: product.quantity)
      total = (product.quantity)*(product.price)
      product_price_lists << total
      product.quantity = 1
      product.save
    end
    @product_prices = product_price_lists
    UserOrderMailer.with(order: @user_order,product: products, amount: @total_amount).new_order(current_user).deliver_now
    session[:cart] = nil
  end
  
end