class CartController < ApplicationController
  before_action :cart_price_with_shipping
  def index
    @total_price_with_coupon = params[:total].to_i
    @percent_off = params[:coupon_off].to_i
  end

  def create
    id = params[:id].to_i
    a = session[:cart] << id unless session[:cart].include?(id)
    respond_to do |format|
      if a != nil
        format.html { redirect_to request.referrer, notice: "Product added successfully." }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    
    end
  end

  def destroy
    id = params[:id].to_i
    session[:cart].delete(id)
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "product removed successfully." }
      format.json { head :no_content }
    end
  end

  def decrease_quantity
    @product_item = Product.find(params[:id])
    @product_item.quantity -= 1
    @product_item.save
    redirect_to request.referrer
  end

  def increase_quantity
      @product_item = Product.find(params[:id])
      @product_item.quantity += 1
      @product_item.save
      redirect_to request.referrer
  end

  private


  def cart_price_with_shipping
    @cart_products = []
    @cart.each do |product|
        @total_price = (product.quantity)*(product.price).to_i
        @cart_products << @total_price
    end
    @tp = @cart_products.inject {|sum,price| sum + price}
    @cart_product_price = @tp.to_i
    @cart_product_price > 500 ? shipping_charge = 0 : shipping_charge = 25
    @applied_shipping_charge = shipping_charge
    @products_price = @cart_product_price + shipping_charge
  end
  
end
