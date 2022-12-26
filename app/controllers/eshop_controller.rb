class EshopController < ApplicationController
    skip_before_action :authenticate_user!
    # before_action :set_total_price, only: [:checkout]

    def index
        @banners = BannerManagement.all
        @products = Product.all.limit(6)
        @category = Category.where(parent_id: nil)
    end

    def shopping_cart
        
    end

    def login
        
    end

    def product_details
        @category = Category.find(params[:id])
        @products = @category.products
    end

    def shop
        @category = Category.where(parent_id: nil)
    end

    def blog
        @category = Category.where(parent_id: nil)

    end
    def blog_single
        @category = Category.where(parent_id: nil)
    end

    def add_user_address
        @user_address = UserAddress.new(user_address_params)
        user_address_params.each do |item|
            @item_params = item[1][1]
        end
        if @item_params==nil
            puts "#{@user_address.errors.full_messages}"
            redirect_to eshop_cart_path
        else
            @user_address.save
            redirect_to eshop_cart_path
        end  
    end  

    def cart
        @category = Category.where(parent_id: nil)

        @sum = 0
        @item = @cart.each do |item|
            # binding.pry
            @sum += item.price.to_i
        end
        @shipping_charge = 25
        @max_shipping_charge = 500
        @user = current_user
        @used_coupon = params[:code]
        cp = Coupon.find_by(code: @used_coupon)
        # binding.pry
        #    cp = Coupon.where(code: @used_coupon)
        @coupons = Coupon.all
        # coupons = []
        number_of_uses = 0
        
        @coupons.each do |coupon|
            binding.pry
            # coupons << c.code
            # coupons.each do |ele|
            if @used_coupon == coupon.code
                # binding.pry
                if @user.coupons.include?(cp)
                    puts "*****coupn already used************************"
                else
                    @percent_off = coupon.percent_off
                    @total = @sum - @percent_off
                    puts "******************valid coupon applied*******************************"
                    binding.pry
                    coupon.number_of_uses += 1
                    @user.coupons << coupon
                end
            end
        end
    end

    
    
    def checkout

        @user_order = UserOrder.new
        @user_addresses = UserAddress.last
        # binding.pry
    end
    
    def user_order_information
        
        @user_address = current_user.user_addresses.build(user_address_params)
        binding.pry
        if @user_address.save
            puts "################## data is saved #################"
            redirect_to eshop_checkout_path
        else
            render 'eshop/checkout'
        end
    end
    def contact_us

    end
    def error404
        
    end
    def payment_success
        binding.pry
        @user_order = current_user.user_orders.last
    end

       
    def add_to_cart
        id = params[:id].to_i
        a = session[:cart] << id unless session[:cart].include?(id)
        # binding.pry   @product_price_lists = [] 
       
        redirect_to add_to_cart_path
    end
    
    def remove_from_cart
        id = params[:id].to_i
        session[:cart].delete(id)
        redirect_to remove_from_cart_path
    end
    def remove_from_cart1
        id = params[:id].to_i
        session[:cart].delete(id)
        redirect_to eshop_cart_path
    end

   
    def decrease_quantity
        @product_item = Product.find(params[:id])
        @product_item.quantity -= 1
        @product_item.save
    end

    def increase_quantity
        @product_item = Product.find(params[:id])
        session[:quantity] = 0
        @quantity = session[:quantity]
        @quantity += 1

    end

    private

    def user_address_params
        params.require(:user_address).permit(:shipping_address, :city, :state, :country, :zipcode)
    end

    def user_order_params
        params.require(:user_order).permit(:full_name, :mobile_number, :email, :address_1, :billing_state, :billing_city, :billing_zipcode, :address_2, :shipping_state, :shipping_city, :shipping_zipcode)
    end
end
