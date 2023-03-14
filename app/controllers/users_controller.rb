class UsersController < ApplicationController
  before_action :get_user_details
  def subscribe  
    service = Mailchimp.new(@user_details)
    response = service.execute 
    binding.pry
    if response[:success] 
      if current_user.subscribe(response[:status])
        flash[:notice] = "Subscribed to mailchimp!"
      else
        flash[:alert] = "Subscription failed"
      end
    else
      flash[:alert] = "Please make sure that you enter the address or your email id is correct."
    end
    redirect_to root_path
  end 

  private

  def get_user_details
    address = current_user.addresses.last
    @user_details = {
                      email: current_user.email, 
                      fname:current_user.firstname, 
                      lname: current_user.lastname,
                      addr1: address.shipping_address,
                      city: address.city,
                      state: address.state,
                      zip: address.zipcode
                    }
  end

end