class ContactMailer < ApplicationMailer
    def contact_mail(current_user)
        binding.pry
        @user = current_user
        @contact = params[:contact]
        mail(to: @user.email, subject: "Your responce sent successfully.")
    end
end
