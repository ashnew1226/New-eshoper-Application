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
        if user.coupons.exclude(available_coupon)
          coupon_off = coupon.percent_off
          coupon.number_of_uses += 1
          total = cart_price - coupon_off
          user.coupons << coupon
          session[:coupon] = coupon
          redirect_to cart_index_path, notice: "Coupon applied successfully." 
        else
          redirect_to cart_index_path, alert: "Coupon allready used"                        
        end
      else
        flash[:alert] = "Invalid coupon"                        
      end
    end
  end
    
end
