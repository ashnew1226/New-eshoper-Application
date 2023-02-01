class ProductController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    binding.pry
    @product = Product.find(params[:id])
  end
end
