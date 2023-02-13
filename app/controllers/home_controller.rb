class HomeController < ApplicationController
  before_action :authenticate_user!
   
  def index
    @banners = BannerManagement.all
    @products = Product.all.limit(6)
    @category = Category.where(parent_id: nil)
  end

  def add_subscription_mailchimp
    service = Mailchimp.execute(email: params[:email], fname: params[:fname], lname: params[:lname],addr1: params[:addr1],city: params[:city],state: params[:state],zip: params[:zip]) 
    flash[:notice] = "subscribed !!!"
    rescue MailchimpMarketing::ApiError => e
    puts "Error: #{e}"
    flash[:alert] = "Please make sure that you enter the address or your email id is correct."
    redirect_to root_path
  end

end 