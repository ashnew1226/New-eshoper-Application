class UsersController < ApplicationController
    def index
        @user_profile_image = current_user.image
    end

    def myorder
        @user_profile_image = current_user.image
        @my_order = current_user.user_orders
        @order_details = OrderDetail.all
        # binding.pry
        
    end

    def track_order
        @user_profile_image = current_user.image
        @user_profile_image = current_user.image
        order_id = params[:user_order_id]
        user_order = current_user.user_orders.find_by(id: order_id)
        # binding.pry
        if user_order.present?
            @user_order = user_order
        else
            flash[:notice] = "Please enter correct order id."
        end
    end
    
end
