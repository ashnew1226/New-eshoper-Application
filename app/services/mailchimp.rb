class Mailchimp
	def self.execute(email:, fname:, lname:, addr1:, city:, state:, zip:)
		client = MailchimpMarketing::Client.new()
		client.set_config({
			:api_key => '5bac1b07f0e243c9e9a44971ce8f4f79',
			:server => 'us11'
		})
		list_id = "e6757e33e0"
		result = client.lists.add_list_member list_id, 
		{ email_address: email,
		status: "subscribed",
		merge_fields: 
								{ FNAME: fname,
								LNAME: lname,
								ADDRESS: { addr1: addr1,
													city: city,
													state: state,
													zip: zip,
												},
						},
		}

	end

end