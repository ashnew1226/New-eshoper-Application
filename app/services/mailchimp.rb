# frozen_string_literal: true

# mailchimp api service
class Mailchimp
  def initialize(user_details)
    @user_details = user_details
  end

  def execute
    begin
      client = MailchimpMarketing::Client.new
      client.set_config({ api_key: ENV['MAILCHIMP_API_KEY'], server: ENV['DC_KEY'] })
      response = client.lists.add_list_member(ENV['MAILCHIMP_AUDIENCE_ID'], {
        email_address: @user_details[:email],
        status: 'subscribed',
        merge_fields:  { 
          FNAME: @user_details[:fname],
          LNAME: @user_details[:lname],
          ADDRESS: { addr1: @user_details[:addr1], city: @user_details[:city], state: @user_details[:state], zip: @user_details[:zip] }
        }
        })

      get_response( true, response["status"])
    rescue MailchimpMarketing::ApiError => e
      get_response( false, e.status)
    end
  end

  def get_response(success, status)
    response_hash = {success: success, status: status}
  end
  
end