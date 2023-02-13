class ProfileController < ApplicationController
  
  def edit
    @profile = User.find(current_user.id)
  end
  
  def myorder
    @user_profile_image = current_user.image
    @my_order = current_user.user_orders
    @order_details = OrderDetail.all   
  end

  def update
    respond_to do |format|
      if @profile.update(user_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def track_order
    order = current_user.user_orders.all
    order_id = params[:user_order_id].to_i
    if (order.ids).include?(order_id)
      @user_order = current_user.user_orders.find_by(id: order_id)
    elsif order_id != 0 && (order.ids).include?(order_id) == false
      flash[:notice] = "Please enter correct order id."
    end
  end

  private
  
  def user_params
    params.require(:user).permit( :firstname, :email, :lastname)    
  end

end
