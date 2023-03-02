class CategoriesController < ApplicationController

  def index
    @category = Category.with_subcategories
  end

  def show
    @category = Category.with_subcategories
    @parent_category = Category.find(params[:id])
    @products = @parent_category.products
  end
  
end