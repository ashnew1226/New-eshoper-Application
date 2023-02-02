class CartController < ApplicationController
  def index
  end

  def create
    id = params[:id].to_i
    a = session[:cart] << id unless session[:cart].include?(id)
    respond_to do |format|
      if a != nil
        format.html { redirect_to product_index_url(@product), notice: "Product added successfully." }
        format.json { render :index, status: :created, location: @cart }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    
    end
  end

  def destroy
    id = params[:id].to_i
    session[:cart].delete(id)
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: "product removed successfully." }
      format.json { head :no_content }
    end
  end
end
