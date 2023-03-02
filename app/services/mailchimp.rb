# frozen_string_literal: true

# mailchimp api service
class Mailchimp
  def self.execute(user_params:)
    client = MailchimpMarketing::Client.new
    client.set_config({ api_key: ENV['MAILCHIMP_API_KEY'], server: ENV['DC_KEY'] })
    client.lists.add_list_member(ENV['MAILCHIMP_AUDIENCE_ID'], {
    email_address: user_params[:email],
    status: 'subscribed',
    merge_fields: user_params_test(user_params: user_params) 
                                })
  end
  
  def self.user_params_test(user_params:)
    { 
     FNAME: user_params[:fname],
     LNAME: user_params[:lname],
     ADDRESS: { addr1: user_params[:addr1], city: user_params[:city], state: user_params[:state], zip: user_params[:zip] }
    }
  end
end