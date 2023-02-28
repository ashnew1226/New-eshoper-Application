class CheckoutController < ApplicationController
  
  def index
    products = Product.all
    @products_purchase = @cart
    @total_amount = session[:cart_hash]["products_price"].to_i
  end

end