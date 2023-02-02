class CartController < ApplicationController
  def index
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
end
