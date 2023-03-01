class ProductsController < ApplicationController

  def index
    if params[:filter].present? && params[:filter][:amount].present?
      @products = Product.costs_less_than(params[:filter][:amount])
    elsif params[:search].present? && params[:search][:key].present?
      key = "%#{params[:search][:key]}%"
      @products = Product.search(key)
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end
  
end
