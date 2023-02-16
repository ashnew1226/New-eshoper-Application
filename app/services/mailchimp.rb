class Mailchimp
	def self.execute(email:, fname:, lname:, addr1:, city:, state:, zip:)
		client = MailchimpMarketing::Client.new()
		client.set_config({
			:api_key => ENV['mailchimp_api_key'],
			:server => ENV['DC_key']
		})
		list_id = ENV['mailchimp_audience_id']
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