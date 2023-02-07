class CouponsController < ApplicationController
    
    def new
        @coupon = Coupon.all
    end

    def apply_coupon
        @user = current_user
        @used_coupon = params[:code]
        @cp = Coupon.find_by(code: @used_coupon)
        @coupons = Coupon.all
        number_of_uses = 0
        cart_price = params[:cart_sub_total].to_i
        
        @coupons.each do |coupon|
            if @used_coupon == coupon.code
                
                if @user.coupons.exclude?(@cp)
                    coupon_off = coupon.percent_off
                    coupon.number_of_uses += 1
                    @total = cart_price - coupon_off
                    @user.coupons << coupon
                    redirect_to cart_index_path(total: @total,coupon: coupon), notice: "Coupon applied successfully." 
                    binding.pry
                else
                    redirect_to cart_index_path,alert: "coupon allready used"                        
                end
            else
                flash[:alert] = "invalid coupon"                        
            end
            
        end
        redirect_to cart_index_path
    end
    def show
        
    end
    

end
