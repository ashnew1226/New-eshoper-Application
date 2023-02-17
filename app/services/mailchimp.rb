class Mailchimp
	def self.execute(email:, fname:, lname:, addr1:, city:, state:, zip:)
		client = MailchimpMarketing::Client.new()
		client.set_config({
			:api_key => ENV['MAILCHIMP_API_KEY'],
			:server => ENV['DC_KEY']
		})
		list_id = ENV['MAILCHIMP_AUDIENCE_ID']
		result = client.lists.add_list_member list_id, 
		{ email_address: email,
		status: "subscribed",
		merge_fields: 
								{ FNAME: fname,
									LNAME: lname,
									ADDRESS: { 	addr1: addr1,
															city: city,
															state: state,
															zip: zip,
														},
								},
		}

	end

end