class EshopController < ApplicationController
    before_action :authenticate_admin, only: [:report]
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
        @cms = ContentManagementSystem.last
    end

    def shopping_cart
        
    end

    def login
        
    end
    def wishlist
        @wishlist = current_user.wishlists.all
        @cms = ContentManagementSystem.last

    end
    def add_to_wishlist
        @wishlist = Wishlist.all
        product = Product.find(params[:id])
        @wishlist_product = current_user.wishlists.find_by(product_id: product.id)
        if @wishlist.include?(@wishlist_product)
            flash[:alert] = "Product allready present in wishlist"
            redirect_to root_path
        else 
            @wishlist_product = current_user.wishlists.find_or_create_by(product_id: product.id)
            flash[:notice] = "Product added to wishlist"
            redirect_to root_path
        end
    end
    def remove_from_wishlist
        product = Product.find(params[:id])
        @wishlist_product = current_user.wishlists.find_by(product_id: product.id)
        if @wishlist_product.destroy
            flash[:alert] = "Product deleted successfully."
            redirect_to eshop_wishlist_path
        end
    end
    def cat_prods
        @category = Category.where(parent_id: nil)
        @cms = ContentManagementSystem.last
        @categor = Category.find(params[:id])
        @products = @categor.products
    end
    def product_details
        @product = Product.find(params[:id])
        # binding.pry
        @category = Category.where(parent_id: nil)
        @cms = ContentManagementSystem.last
        # @products = @categor.products
    end
    def shop
        @category = Category.where(parent_id: nil)
        @products = Product.all
        @cms = ContentManagementSystem.last
    end

    def blog
        @category = Category.where(parent_id: nil)
        @cms = ContentManagementSystem.last

    end
    def blog_single
        @category = Category.where(parent_id: nil)
        @cms = ContentManagementSystem.last
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
        @cms = ContentManagementSystem.last
        @category = Category.where(parent_id: nil)
        price_with_coupon
        @produts_price = cart_price_with_shipping
        if @total.present?
            session[:total_amount] = @total
        else
            session[:total_amount] = @produts_price
        end
    end
    def report
        
    end    
    
    def apply_coupon
        redirect_to eshop_checkout_path(price: params[:price])
    end
    
    def checkout
        # binding.pry
        if params[:coupon].present?
            @coupon = Coupon.find(params[:coupon])
        end
        @cms = ContentManagementSystem.last
        @user_order = UserOrder.new
        if user_shipping_address.blank?
            
        else
            @address = user_shipping_address.join(" ")
        end
    end
    
    def user_order_information
        @user_address = current_user.user_addresses.new(user_address_params)
        if @user_address.save
            respond_to do |format|
                if @user_address.save
                    binding.pry
                    format.html { redirect_to eshop_checkout_path, notice: 'Your responce submitted successfully' }   
                    format.json { render :checkout, status: :created, location: @user_addres }
                else
                    format.html { render :checkout }   
                    format.json { render json: @user_address.errors, status: :unprocessable_entity }
                end
            end
        end
    end
    def contact
        @contact = Contact.new
        @contact_detail = Contact.all
    end
    def contact_us
        @cms = ContentManagementSystem.last
        @contact = current_user.contacts.build(contact_params)
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
            response = client.lists.get_list_members_info(list_id)
            
            flash[:notice] = "subscribed !!!"
            rescue MailchimpMarketing::ApiError => e
            puts "Error: #{e}"
            flash[:alert] = "please make sure that you enter the address or your email id is correct."
            redirect_to root_path
    end

    def payment_success
        @cms = ContentManagementSystem.last
        @user_order = current_user.user_orders.last
    end

       
    def add_to_cart
        @category = Category.where(parent_id: nil)
        id = params[:id].to_i
        a = session[:cart] << id unless session[:cart].include?(id)
        redirect_to root_path
        flash[:notice] = "product added successfully"
    end
    
    def remove_from_cart
        id = params[:id].to_i
        session[:cart].delete(id)
        redirect_to remove_from_cart_path
        flash[:notice] = "product removed successfully"

    end
    def remove_from_cart1
        id = params[:id].to_i
        session[:cart].delete(id)
        redirect_to eshop_cart_path
        flash[:notice] = "product removed successfully"

    end

   
    def decrease_quantity
        @product_item = Product.find(params[:id])
        @product_item.quantity -= 1
        @product_item.save
        redirect_to eshop_cart_path
    end

    def increase_quantity
        @product_item = Product.find(params[:id])
        @product_item.quantity += 1
        @product_item.save
        redirect_to eshop_cart_path
    end
    def cash_on_delivery
        binding.pry
        if params[:coupon].present?
            @coupon = Coupon.find(params[:coupon])
        end
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
        user_address = current_user.user_addresses.last
        if params[:coupon].present?
            @coupon = Coupon.find(params[:coupon])
            @user_order = UserOrder.create(user_id: current_user.id, order_status: status, user_address_id: user_address.id,coupon_id: @coupon.id)
        end
		@user_order = UserOrder.create(user_id: current_user.id, order_status: status, user_address_id: user_address.id)
        if @user_order.save
            products.each do |product|
                @user_order.order_details.create(product_id: product.id,amount: product.price,quantity: product.quantity)
                total = (product.quantity)*(product.price)
                product_price_lists << total
                # binding.pry
                product.quantity = 1
                product.save

            end

            @product_prices = product_price_lists
            UserOrderMailer.with(order: @user_order,product: products, amount: @total_amount).new_order(current_user).deliver_now
            session[:cart] = nil
		end
    end
    def generate_report
        orders = UserOrder.all
        @products = []
        @product_price = []
        orders.each do |single|
            single.products.each do|product|
                @product_price << product.price
                @id = product.id
            end
            @products << single.products

        end
        coupon = Coupon.all
        coupons_used = CouponsUsed.all
        customers_registered = User.all
        neaa = @products

        price = @product_price
        price_total = @product_price.inject {|sum,price| sum + price}
        sales_report = SalesReport.create(total_saled_products: neaa.size, products_total_price: price_total,total_coupons: coupon.size, coupons_used: coupons_used.size,customers_registered: customers_registered.size)
        redirect_to eshop_report_path
        flash[:notice] = "report generated successfully"
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
    
    def authenticate_admin
        if current_user.superadmin_role?
            redirect_to(eshop_report_path)
        else
            redirect_to root_path
            flash[:alert] = "you are not authorized user to access this page"
        end
    end
    
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
    def price_with_coupon
        @user = current_user
        @used_coupon = params[:code]
        @cp = Coupon.find_by(code: @used_coupon)
        @coupons = Coupon.all
        number_of_uses = 0
        @coupons.each do |coupon|
            if @used_coupon == coupon.code
                if @user.coupons.include?(@cp)
                    puts "*****coupn already used************************"
                    flash[:alert] = "Coupon already used"

                else
                    @percent_off = coupon.percent_off
                    puts "******************valid coupon applied*******************************"
                    flash[:notice] = "Coupon applied successfully"
                    coupon.number_of_uses += 1
                    @total = cart_price_with_shipping - @percent_off
                    @user.coupons << coupon
                    return @total
                    
                end
            end
            if @used_coupon != coupon.code && @cp.blank?
                @cp
            end
        end 
    end
    def final_price_checkout
        a = set_total_price
        b = cart_price_with_shipping
    end

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
