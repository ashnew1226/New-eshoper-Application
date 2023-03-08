class UsersController < ApplicationController
  def subscribe  
    service = Mailchimp.execute(get_user_details: get_user_details, user: current_user) 
    flash[:notice] = "subscribed to mailchimp !!!"
      rescue MailchimpMarketing::ApiError => e
        flash[:alert] = "Please make sure that you enter the address or your email id is correct."
    redirect_to root_path
  end 

  def get_user_details
    address = current_user.addresses.last
    {
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
