class WishlistController < ApplicationController
  def index
    @wishlist = current_user.wishlists
  end

  def create
    product = Product.find(params[:id])
    @wishlist_product = current_user.wishlists.find_by(product_id: product.id)
    @wishlist_products = current_user.wishlists

    respond_to do |format|
      if @wishlist_products.include?(product)
        format.html { render :index, status: :unprocessable_entity, alert: "product is allready present in wishlist" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      else
        @wishlist_product = current_user.wishlists.find_or_create_by(product_id: product.id)
        format.html { redirect_to wishlist_index_url(@product), notice: "product added successfully." }
        format.json { render :index, status: :created, location: @product }
      end
    end
  end

  def destroy
    product = Product.find(params[:id])
    @wishlist_product = current_user.wishlists.find_by(product_id: product.id)
    @wishlist_product.destroy
    respond_to do |format|
      format.html { redirect_to wishlist_index_url, alert: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
end
