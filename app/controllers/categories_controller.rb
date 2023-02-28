class CategoriesController < ApplicationController

  def index
    @category = Category.with_subcategory
  end

  def show
    @category = Category.with_subcategory
    @parent_category = Category.find(params[:id])
    @products = @parent_category.products
  end
  
end
