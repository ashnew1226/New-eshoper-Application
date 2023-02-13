class CheckoutController < ApplicationController

  def index
    products = Product.all
    @products_purchase = @cart
    @total_amount = session[:cart_hash]["products_price"].to_i
    @products_subscription = products.where(name:nil, name:nil)
    unless user_shipping_address.blank?
      @address = user_shipping_address.join(" ")
    end
  end

  private

  def user_shipping_address
    @user_address = current_user.user_addresses.last
    @address = []
    unless @user_address.blank?
      @address << @user_address.shipping_address
      @address << @user_address.city
      @address << @user_address.state
      @address << @user_address.country
      @address << @user_address.zipcode
      @newaddress = @address
    end
  end

end