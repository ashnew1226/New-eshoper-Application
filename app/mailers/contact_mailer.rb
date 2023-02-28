class ContactMailer < ApplicationMailer

	def contact_mail(current_user)
		@user = current_user
		@contact = params[:contact]
		mail(to: @user.email, subject: "Your response sent successfully.")
	end

	def contact_admin_mail(contact)
		@contact = contact
		mail(to: @contact.email, subject: "Your response sent successfully.")
	end

	def daily_queries
		admin_user = User.admin
		@queries = Contact.recent_customer_queries
		@replied_queries = Contact.recent_replied_queries
		mail(to: admin_user.email, subject: "daily contacted customers")
	end
	
end
