class HomeController < ApplicationController

  def index
    @banners = BannerManagement.all
    @products = Product.all.take(6)
    @category = Category.with_subcategories
  end

  def add_subscription_mailchimp
    user_params = {email: params[:email], fname: params[:fname], lname: params[:lname],addr1: params[:addr1],city: params[:city],state: params[:state],zip: params[:zip]}
    service = Mailchimp.execute(user_params: user_params) 
    flash[:notice] = "subscribed !!!"
    rescue MailchimpMarketing::ApiError => e
    puts "Error: #{e}"
    flash[:alert] = "Please make sure that you enter the address or your email id is correct."
    redirect_to root_path
  end

end 