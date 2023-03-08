class CouponsController < ApplicationController
    
  def new
    @coupon = Coupon.all
  end

  def apply_coupon
    user = current_user
    available_coupon = Coupon.find_by(code: params[:code])
    coupons = Coupon.all
    number_of_uses = 0
    cart_price = params[:cart_sub_total].to_i
    coupons.each do |coupon|
      if params[:code] == coupon.code
        if user.coupons.where(:code => available_coupon.code).present?
          redirect_to carts_path, alert: "Coupon allready used"                        
        else
          coupon_off = coupon.percent_off
          coupon.number_of_uses += 1
          total = cart_price - coupon_off
          user.coupons << coupon
          session[:coupon] = coupon
          redirect_to carts_path, notice: "Coupon applied successfully." 
        end
      else
        flash[:alert] = "Invalid coupon"        
      end
    end
  end
    
end
