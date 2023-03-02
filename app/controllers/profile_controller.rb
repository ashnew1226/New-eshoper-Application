class ProfileController < ApplicationController
  
  def edit
    @profile = User.find(current_user.id)
  end
  
  def myorder
    @my_order = current_user.orders
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def track_order
    order = current_user.orders.all
    @order_id = params[:order_id].to_i
    if (order.ids).include?(@order_id)
      @order = current_user.orders.find_by(id: @order_id)
    elsif @order_id != 0 && (order.ids).include?(@order_id) == false
      flash[:notice] = "Please enter correct order id."
    end
  end

  private
  
  def profile_params
    params.require(:user).permit( :firstname, :email, :lastname)    
  end

end
