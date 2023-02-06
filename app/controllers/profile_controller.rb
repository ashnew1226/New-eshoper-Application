class ProfileController < ApplicationController
    def index
        @user = current_user
        # binding        
    end
    
    def new
        @user = User.new
    end
    def edit

    end
    
    def myorder
        @user_profile_image = current_user.image
        @my_order = current_user.user_orders
        @order_details = OrderDetail.all
        # binding.pry
        
    end
    def update
        respond_to do |format|
            if @contact.update(user_params)
              format.html { redirect_to profile_url(@user), notice: "profile was successfully updated." }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
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
private

def user_params
    params.require(:user).permit( :firstname, :email, :lastname)    
end


# id = params[:user_order_id].to_i
# 		if (order.ids).include?(id)
 
#       @user_order = UserOrder.find_by(id: id)
#     elsif id != 0 && (order.ids).include?(id)
#  == false  #if we convert nil to integer we get 0 so wrote 0 instead of nil
#       flash[:alert] = "incorrect order id"
#     end
