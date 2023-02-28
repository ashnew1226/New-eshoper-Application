class OrdersController < ApplicationController
  before_action :prepare_new_order, only: [:stripe_create_payment]
  require 'stripe'
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  include AddressesHelper

  def index
    products = Product.all
    @products_purchase = @cart
    @total_amount = session[:cart_hash]["products_price"].to_i
   
  end

  def submit
    if params[:payment_method].present?
      cash_on_delivery
    else
      if order_params[:payment_gateway] == "stripe"
        @product = prepare_new_order
        @address = Address.find(params[:address])
        @orders_products = @cart
        @total_amount = params[:orders][:total].to_i
        Stripes.execute(
                      order: @order, user: current_user,
                      product: @product, amount: @total_amount,
                      address: @address, coupon: @coupon
                      )
      end
    end
  ensure
    if  params[:payment_method] == "COD"
      return render 'orders/show'
      session[:cart_hash] = nil
    else
      if @order&.save
        if @order.paid?
          product_price_lists = []
          products = Product.where(id: @cart.map(&:id))
          products.each do |product|
            @order.order_details.create(
                                            product_id: product.id,
                                            amount: product.price,
                                            quantity: product.quantity
                                            )
            total = (product.quantity)*(product.price)
            product_price_lists << total
            product.quantity = 1
            product.save
          end
          OrderMailer.with(order: @order,product: products, amount: @total_amount).new_order(current_user).deliver_now
          session[:cart] = nil
          return render "orders/show"
        elsif @order.failed? && !@order.error_message.blank?
          return render html: @order.error_message
        end
      end
    end
  end
  
  def show
    @order = current_user.orders.last
  end

  private

  def prepare_new_order
    @address = current_user.addresses.last
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @product = Product.find(params[:orders][:product_id])
    end
    
  def order_params
      params.require(:orders).permit(:token, :payment_gateway, :charge_id, :amount, :status)
  end

  def cash_on_delivery
    @order = Order.new
    product_price_lists = []
    @total_amount = params[:final_price]
    products = Product.where(id: @cart.map(&:id))
    status = @order.set_order
    address = current_user.addresses.last
    if params[:coupon].present?
        @coupon = Coupon.find(params[:coupon])
        @order = Order.create(id: current_user.id, order_status: status, address_id: address.id,coupon_id: @coupon.id)
    else
      @order = Order.create(id: current_user.id, order_status: status, address_id: address.id)
    end
    products.each do |product|
      @order.order_details.create(product_id: product.id,amount: product.price,quantity: product.quantity)
      total = (product.quantity)*(product.price)
      product_price_lists << total
      product.quantity = 1
      product.save
    end
    @product_prices = product_price_lists
    OrderMailer.with(order: @order,product: products, amount: @total_amount).new_order(current_user).deliver_now
    session[:cart] = nil
  end
  
end