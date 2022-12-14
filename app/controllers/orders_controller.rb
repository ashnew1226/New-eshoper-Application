class OrdersController < ApplicationController
  before_action :prepare_new_order, only: [:stripe_create_payment]

    def index
      products = Product.all
      @products_purchase = products
      @products_subscription = products.where(name:nil, name:nil)
    end
  
    def submit
      @order = nil
      if order_params[:payment_gateway] == "stripe"
        prepare_new_order
        UserOrders::Stripe.execute(user_order: @order, user: current_user)
      elsif order_params[:payment_gateway] == "paypal"
        #PAYPAL WILL BE HANDLED HERE
      end
    ensure
      if @order&.save
        if @order.paid?
          # Success is rendered when order is paid and saved
          return render html: SUCCESS_MESSAGE
        elsif @order.failed? && !@order.error_message.blank?
          # Render error only if order failed and there is an error_message
          return render html: @order.error_message
        end
      end
      render html: 'orders/index'
    end
  
    private
    # Initialize a new order and and set its user, product and price.
    def prepare_new_order
      @user_order = UserOrder.new(order_params)
      @user_order.user_id = current_user.id
      @product = Product.find(params[:user_orders][:product_id])
      binding.pry
      @order.price = @product.price
    end
  
    def order_params
      params.require(:user_orders).permit(:token, :payment_gateway, :charge_id)
    end
    
  end