class OrdersController < ApplicationController
  before_action :prepare_new_order, only: [:stripe_create_payment]
  before_action :total_amount
    require 'stripe'
    Stripe.api_key = 'sk_test_51ME59WSDCO9rQieouDgPB589PVx9cdYWonNq11UlMzvKx3K2jpon9sLXMdwrrCTcpMEXFk25r9F1XBYo7LcfX0uc00DXuFAO1L'
    def index
      products = Product.all
      @products_purchase = @cart
      @total_amount = session[:total_amount]
      # binding.pry
      @products_subscription = products.where(name:nil, name:nil)
    end
  
    def submit
      if order_params[:payment_gateway] == "stripe"
       @product = prepare_new_order
        Orders::Stripe.execute(user_order: @user_order, user: current_user, product: @product, amount: total_amount)
      end
    ensure
      if @user_order&.save
        if @user_order.paid?
          product_price_lists = []
          @total_amount = session[:total_amount]
          products = Product.where(id: @cart.map(&:id))
          products.each do |product|
            @user_order.order_details.create(product_id: product.id,amount: product.price,quantity: product.quantity)
            total = (product.quantity)*(product.price)
            product_price_lists << total
          end
          UserOrderMailer.with(order: @user_order,product: products, amount: @total_amount).new_order(current_user).deliver_now
          return render 'eshop/payment_success'
        elsif @user_order.failed? && !@user_order.error_message.blank?
          return render html: @user_order.error_message
        end
      end
      render html: 'Error'
    end
  
    private
    # Initialize a new order and and set its user, product and price.
    def prepare_new_order
      @user_order = UserOrder.new(order_params)
      @user_order.user_id = current_user.id
      @user_product = Product.find(params[:user_orders][:product_id])
    end
    
    def order_params
      params.require(:user_orders).permit(:token, :payment_gateway, :charge_id, :amount, :status)

    end

    def total_amount
      @cart_products = []
        @cart.each do |product|
            @total_price = (product.quantity)*(product.price).to_i
            @cart_products << @total_price
        end
        @tp = @cart_products.inject {|sum,price| sum + price}
        @max_total = @tp.to_i
    end
    
  end