class ProductsController < ApplicationController

  def index
    @products = Product.all
    
  end

  def show
    @product = Product.find(params[:id])
  end

  def filter
    @products = Product.costs_less_than(params[:option])
  end
  
end
