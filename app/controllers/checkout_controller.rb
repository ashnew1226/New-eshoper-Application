class CheckoutController < ApplicationController
  def index
    @final_price = params[:final_price]
    if params[:coupon].present?
      @coupon  = Coupon.find(params[:coupon])
    end
    if user_shipping_address.blank?
    else
        @address = user_shipping_address.join(" ")
    end
  end

  private
  def user_shipping_address
    @user_address = current_user.user_addresses.last
    @address = []
    if @user_address.blank?
    else
        @address << @user_address.shipping_address
        @address << @user_address.city
        @address << @user_address.state
        @address << @user_address.country
        @address << @user_address.zipcode
        @newaddress = @address
    end
  end

end