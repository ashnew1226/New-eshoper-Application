class CartsController < ApplicationController
  before_action :cart_price_with_shipping
  before_action :set_cart_product, except: [:index]

  def index
    @total_price_with_coupon = params[:total].to_i
    if params[:coupon].present?
      @coupon = Coupon.find(params[:coupon])
    end
  end

  def create
    # product_id = params[:id].to_i if params[:id].present?
    cart = session[:cart] << @product.id unless session[:cart].include?(@product.id)
    respond_to do |format|
      if cart.exclude?(@cart)
        format.html { redirect_to request.referrer, notice: "Product added successfully." }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # product_id = params[:id].to_i if params[:id].present?
    session[:cart].delete(@product.id)
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Product removed successfully." }
      format.json { head :no_content }
    end
  end

  def increase_quantity
    @product.update(quantity: @product.quantity += 1)
    redirect_to request.referrer
  end

  def decrease_quantity
    @product.update(quantity: @product.quantity -= 1)
    redirect_to request.referrer
  end

  private

  def cart_price_with_shipping
    cart_products = []
    @cart.each do |product|
      total_price = (product.quantity)*(product.price).to_i
      cart_products << total_price
    end
    total_price = cart_products.inject {|sum, price| sum + price}
    cart_product_price = total_price.to_i
    cart_product_price > 500 ? shipping_charge = 0 : shipping_charge = 25
    applied_shipping_charge = shipping_charge
    products_price = cart_product_price + shipping_charge
    @cart_prices = {cart_product_price: cart_product_price, applied_shipping_charge: applied_shipping_charge, products_price: products_price }
    if session[:coupon].present?
      coupon = session[:coupon].to_i
      coupon_id = {coupon: coupon}
      session[:cart_hash] = @cart_prices.merge(coupon) 
    end
    session[:cart_hash] = @cart_prices
  end
  
  def set_cart_product
    @product = Product.find(params[:id])
  end
end
