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
                        puts "******************valid coupon applied*******************************"
                        coupon.number_of_uses += 1
                        @total = cart_price - coupon_off
                        @user.coupons << coupon
                        binding.pry
                        redirect_to cart_index_path(total: @total,coupon_off: coupon_off ), notice: "Coupon applied successfully." 
                        # redirect_to coupons_url(@coupon)
                        # binding.pry
                    else
                        puts "*****coupn already used************************"
                        # binding.pry
                        redirect_to cart_index_path,alert: "coupon allready used"
                        binding.pry
                        # format.json { render json: @coupon.errors, status: :unprocessable_entity }
                        
                    end
                
            end
        end
    end
    def show
        
    end
    

end
