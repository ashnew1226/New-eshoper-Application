class UsersController < ApplicationController
  before_action :get_user_details
  def subscribe  
    service = Mailchimp.new(@user_details)
    response = service.execute 
    if response[:success]
      current_user.subscribe(response[:status])
      flash[:notice] = "subscribed to mailchimp !!!"
    else
      flash[:notice] = response[:error]
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