class UserOrderMailer < ApplicationMailer
    def new_order(current_user)
        binding.pry
        @products = params[:product]
        @order = params[:order]
        @amount = params[:amount]
        @user = current_user
        if @order.payment_gateway.present?
            mail(to: @user.email, subject: "Your order placed successfully with payment.")
        else
            mail(to: @user.email, subject: "Your order placed successfully!")

        end
    end
end
