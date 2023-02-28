class ProductsController < ApplicationController

  def index

    if params[:filter].present? && params[:filter][:option].present? && params[:filter][:dec_option].present?
      cost = {option: params[:filter][:option], dec_option: params[:filter][:dec_option]}
      @products = Product.filter(cost)
    elsif params[:filter].present? && params[:filter][:option].present?
      cost = {option: params[:filter][:option]}
      @products = Product.filter(cost)
      a = "option"
    elsif params[:filter].present? && params[:filter][:dec_option].present?
      cost = {dec_option: params[:filter][:dec_option]}
      @products = Product.filter(cost)
      b = 'dec_option'
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end

end
