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
	
end
