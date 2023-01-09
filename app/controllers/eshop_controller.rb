class EshopController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :set_total_price, only: [:cart]
    before_action :price_with_coupon, only: [:cart,:checkout]
    before_action :final_price_checkout, only: [:checkout]
    before_action :cart_price_with_shipping, only: [:cart]
    before_action :user_shipping_address, only: [:add_subscription_mailchimp]
    # before_action :prepare_new_order, only: [:cash_on_delivary]
    # binding.pry
    def index
        @banners = BannerManagement.all
        @products = Product.all.limit(6)
        @category = Category.where(parent_id: nil)
    end

    def shopping_cart
        
    end

    def login
        
    end
    def wishlist
        @wishlist = Wishlist.all
    end
    def add_to_wishlist
        @wishlist = Wishlist.all
        product = Product.find(params[:id])
        @wishlist_product = current_user.wishlists.find_by(product_id: product.id)
        binding.pry
        if @wishlist.include?(@wishlist_product)
            flash[:alert] = "Product allready present in wishlist"
            redirect_to root_path
        else 
            @wishlist_product = current_user.wishlists.find_or_create_by(product_id: product.id)
            flash[:notice] = "Product added to wishlist"
            redirect_to root_path
        end
        # binding.pry
    end
    def remove_from_wishlist
        product = Product.find(params[:id])
        @wishlist_product = current_user.wishlists.find_by(product_id: product.id)
        if @wishlist_product.destroy
            flash[:alert] = "Product deleted successfully."
            redirect_to eshop_wishlist_path
        end
    end
    def product_details
        @category = Category.find(params[:id])
        @products = @category.products
    end

    def shop
        @category = Category.where(parent_id: nil)
        @products = Product.all
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
        price_with_coupon
        @produts_price = cart_price_with_shipping
        if @total.present?
            session[:total_amount] = @total
        else
            session[:total_amount] = @produts_price
        end
    end

    def apply_coupon
        redirect_to eshop_checkout_path(price: params[:price])
    end
    
    def checkout
        # binding.pry
        @checkout_amount = params[:price]
        puts "*****************#{@checkout_amount}********************"
        @user_order = UserOrder.new
        @user_addresses = UserAddress.last
        # render "eshop/cash"
        # redirect_to cash_on_delivary_path
    end
    
    def user_order_information
        @user_address = current_user.user_addresses.build(user_address_params)
        # binding.pry
        if @user_address.save
            puts "################## data is saved #################"
            redirect_to eshop_checkout_path
        else
            render 'eshop/checkout'
        end
    end
    def contact
          @contact_detail = Contact.all
    end
    def contact_us
        @contact = Contact.new(contact_params)
        respond_to do |format|   
          if @contact.save
            ContactMailer.with(contact: @contact).contact_mail(current_user).deliver_now  
            format.html { redirect_to eshop_contact_path, notice: 'Your responce submitted successfully' }   
            format.json { render :contact, status: :created, location: @contact }   
          else   
            format.html { render :contact }   
            format.json { render json: @contact.errors, status: :unprocessable_entity }   
          end   
        end 
    end
    
    def add_subscription_mailchimp
        client = MailchimpMarketing::Client.new()
            client.set_config({
                :api_key => '5bac1b07f0e243c9e9a44971ce8f4f79',
                :server => 'us11'
            })
            list_id = "e6757e33e0"
            result = client.lists.add_list_member list_id, {
                email_address: params[:email],
                status: "subscribed",
                merge_fields: {
                FNAME: params[:fname],
                LNAME: params[:lname],
                ADDRESS: {
                addr1: params[:addr1],
                city: params[:city],
                state: params[:state],
                zip: params[:zip],
                },
            },
            }
            flash[:notice] = "subscribed !!!"
    end
    

    def error404
        
    end
    def payment_success
        # binding.pry
        @user_order = current_user.user_orders.last
    end

       
    def add_to_cart
        id = params[:id].to_i
        a = session[:cart] << id unless session[:cart].include?(id)
        # binding.pry   @product_price_lists = [] 
        flash[:notice] = "product added successfully"
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
    def cash_on_delivary
        @orders_products = @cart
        @total_amount = session[:total_amount]
        @newaddress = user_shipping_address
    end
    def success
        @user_order = UserOrder.new
        product_price_lists = []
        @total_amount = session[:total_amount]
        products = Product.where(id: @cart.map(&:id))
        status = @user_order.set_order
		@user_order = UserOrder.create(user_id: current_user.id, order_status: status)
        # binding.pry
        if @user_order.save
            products.each do |product|
                @user_order.order_details.create(product_id: product.id,amount: product.price,quantity: product.quantity)
                total = (product.quantity)*(product.price)
                product_price_lists << total
            end
            @product_prices = product_price_lists
            binding.pry
            UserOrderMailer.with(order: @user_order,product: products, amount: @total_amount).new_order(current_user).deliver_now
		end
    end
    private

    def user_address_params
        params.require(:user_address).permit(:shipping_address, :city, :state, :country, :zipcode)
    end

    def user_order_params
        params.require(:user_order).permit(:full_name, :mobile_number, :email, :address_1, :billing_state, :billing_city, :billing_zipcode, :address_2, :shipping_state, :shipping_city, :shipping_zipcode, sta)
    end

    def contact_params
        params.require(:contact).permit(:name, :email, :contact_no, :message)
    end
    

    def set_total_price
        @cart_products = []
        @cart.each do |product|
            @total_price = (product.quantity)*(product.price).to_i
            @cart_products << @total_price
        end
        @tp = @cart_products.inject {|sum,price| sum + price}
        @max_total = @tp.to_i
        # binding.pry
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
    def price_with_coupon
        @user = current_user
        @used_coupon = params[:code]
        cp = Coupon.find_by(code: @used_coupon)
        # binding.pry
        #    cp = Coupon.where(code: @used_coupon)
        @coupons = Coupon.all
        # coupons = []
        number_of_uses = 0
        # "payment successfull with product creation , payment_mode creation and confirming the payment intent for stripe api & navbar links are added"
        @coupons.each do |coupon|
            # binding.pry
            # coupons << c.code
            # coupons.each do |ele|
            # binding.pry
            if @used_coupon == coupon.code
                # binding.pry
                if @user.coupons.include?(cp)
                    puts "*****coupn already used************************"
                    flash[:alert] = "Coupon already used"

                else
                    @percent_off = coupon.percent_off
                    puts "******************valid coupon applied*******************************"
                    # binding.pry
                    flash[:notice] = "Coupon applied successfully"
                    coupon.number_of_uses += 1
                    @total = cart_price_with_shipping - @percent_off
                    # binding.pry
                    # coupon.final_amount = @total
                    @user.coupons << coupon
                    return @total
                    # binding.pry
                    
                end
            end
            # binding.pry
            if @used_coupon != coupon.code && cp.blank?
                cp
            else
                flash[:alert] = "Invalid coupon"
            end
        end 
    end
    def final_price_checkout
        a = set_total_price
        b = cart_price_with_shipping
        # binding.pry
    end

    def user_shipping_address
        @user_address = current_user.user_addresses.last
        # binding.pry
        @address = []
        @address << @user_address.shipping_address
        @address << @user_address.city
        @address << @user_address.state
        @address << @user_address.country
        @address << @user_address.zipcode
        @newaddress = @address

    end
    
    
end
