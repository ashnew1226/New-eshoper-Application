class CartController < ApplicationController
  def index
  end

  def create
    binding.pry
    id = params[:id].to_i
    a = session[:cart] << id unless session[:cart].include?(id)
    respond_to do |format|
      if a != nil
        format.html { redirect_to cart_index_url(@cart), notice: "Post was successfully created." }
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
