class CouponsController < ApplicationController
    def index
        
    end
    def new
        @coupon = Coupon.new
    end
    def create
        @user = current_user
        @used_coupon = params[:code]
        @cp = Coupon.find_by(code: @used_coupon)
        @coupons = Coupon.all
        number_of_uses = 0
    
        @coupons.each do |coupon|
            if @used_coupon == coupon.code
                    if @user.coupons.exclude?(@cp)
                        @percent_off = coupon.percent_off
                        puts "******************valid coupon applied*******************************"
                        coupon.number_of_uses += 1
                        @total = cart_price_with_shipping - @percent_off
                        @user.coupons << coupon
                        redirect_to request.referrer, notice: "Coupon applied successfully." 
                        # redirect_to coupons_url(@coupon)
                        # binding.pry
                    else
                        puts "*****coupn already used************************"
                        # binding.pry
                        redirect_to request.referrer,alert: "coupon allready used"
                        # format.json { render json: @coupon.errors, status: :unprocessable_entity }
                        
                    end
                
            end
        end
    end
    def show
        
    end
    
    private
    def set_total_price
        @cart_products = []
        @cart.each do |product|
            @total_price = (product.quantity)*(product.price).to_i
            @cart_products << @total_price
        end
        @tp = @cart_products.inject {|sum,price| sum + price}
        @max_total = @tp.to_i
    end
    def cart_price_with_shipping
        @cart_product_price = set_total_price
        if @cart_product_price < 500
            @shipping_charge  = 25
        else
            @shipping_charge  = 0
        end
        @applied_shipping_charge = @shipping_charge
        @products_price = @cart_product_price + @shipping_charge

    end
    
end
