class HomeController < ApplicationController
  before_action :authenticate_user!
    def index
      @banners = BannerManagement.all
      @products = Product.all.limit(6)
      @category = Category.where(parent_id: nil)
    end
    def add_subscription_mailchimp
      	client = MailchimpMarketing::Client.new()
          	client.set_config({
              :api_key => '5bac1b07f0e243c9e9a44971ce8f4f79',
              :server => 'us11'
            })
            list_id = "e6757e33e0"
            result = client.lists.add_list_member list_id, {
              email_address: params[:email],
              status: "subscribed",
              merge_fields: {
                FNAME: params[:fname],
                LNAME: params[:lname],
                ADDRESS: {
                  addr1: params[:addr1],
                  city: params[:city],
                  state: params[:state],
                  zip: params[:zip],
                          },
                      },
                  }
      response = client.lists.get_list_members_info(list_id)
      
      flash[:notice] = "subscribed !!!"
      rescue MailchimpMarketing::ApiError => e
      puts "Error: #{e}"
      flash[:alert] = "please make sure that you enter the address or your email id is correct."
      redirect_to root_path
    end
end
