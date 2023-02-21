class CheckoutController < ApplicationController

  def index
    products = Product.all
    @products_purchase = @cart
    @total_amount = session[:cart_hash]["products_price"].to_i
    @products_subscription = products.where(name:nil, name:nil)
    @address = current_user.user_addresses.select(:id,:shipping_address,:city,:state,:zipcode).last(5)
    @addr_hashs = []
    @address.each do |add|
      my_address = "#{add.shipping_address}, #{add.city}, #{add.state} -  #{add.zipcode}"
      @addr_hashs << {id: add.id , address: my_address}
    end

  end

end