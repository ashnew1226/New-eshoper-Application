class UsersController < ApplicationController

    def myorder
        @user_profile_image = current_user.image
        @my_order = current_user.user_orders
        @order_details = OrderDetail.all
        # binding.pry
        
    end

    def track_order
        # binding.pry
        order = current_user.user_orders.all
        order_id = params[:user_order_id].to_i
        if (order.ids).include?(order_id)
            @user_order = current_user.user_orders.find_by(id: order_id)
            # binding.pry
        elsif order_id != 0 && (order.ids).include?(order_id) == false
            flash[:notice] = "Please enter correct order id."
        else 

        end
    end
    
end
# id = params[:user_order_id].to_i
# 		if (order.ids).include?(id)
 
#       @user_order = UserOrder.find_by(id: id)
#     elsif id != 0 && (order.ids).include?(id)
#  == false  #if we convert nil to integer we get 0 so wrote 0 instead of nil
#       flash[:alert] = "incorrect order id"
#     end
