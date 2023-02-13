class WishlistsController < ApplicationController
  before_action :set_product, only: [:create, :destroy]

  def index
    @wishlist = current_user.wishlists
  end

  def create
    wishlist_product = current_user.wishlists.find_by(product_id: @product.id)
    @wishlist_products = current_user.wishlists

    respond_to do |format|
      if @wishlist_products.include?(set_product)
        format.html { render :index, status: :unprocessable_entity, alert: "Product is allready present in wishlist" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      else
        wishlist_product = current_user.wishlists.find_or_create_by(product_id: @product.id)
        format.html { redirect_to wishlists_url(@product), notice: "Product added successfully." }
        format.json { render :index, status: :created, location: @product }
      end
    end
  end

  def destroy
    wishlist_product = current_user.wishlists.find_by(product_id: @product.id)
    wishlist_product.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url, alert: "Removed product from Wishlist successfully." }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
