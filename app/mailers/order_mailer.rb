app/helpers/wishlists_helper.rbclass OrderMailer < ApplicationMailer
    def new_order(current_user)
        @products = params[:product]
        @order = params[:order]
        @amount = params[:amount]
        @user = current_user
        @admin = User.find_by(superadmin_role: true,supervisor_role: true)
        if @order.payment_gateway.present?
            mail(to: @user.email, subject: "Your order placed successfully with payment.")
            mail(to: @admin.email, subject: "placed new order with online payment")
        else 
            mail(to: @user.email, subject: "Your order placed successfully!")
            mail(to: @admin.email, subject: "placed new order with COD")
        end
    end

    def send_order_status(order)
        @order = order
        @user = @order.user
        mail(to: @user.email, subject: "Your order status")
    end
    def daily_order_status
        @admin = User.find_by(superadmin_role: true,supervisor_role: true)
        @total_orders = Order.where(created_at: (Time.now.midnight - 3.day)..Time.now.midnight)
        mail(to: @admin.email, subject: "daily user order status")
    end
    
end
