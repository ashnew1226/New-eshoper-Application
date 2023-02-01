class CategoriesController < ApplicationController
  def index
    @category = Category.where(parent_id: nil)
  end

  def show
    @category = Category.where(parent_id: nil)
    # binding.pry
    @parent_category = Category.find(params[:id])
    @products = @parent_category.products
  end
  
end
