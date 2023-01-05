class UserMailer < ApplicationMailer

    def new_user_email(user)
        @user = user
        mail(to: @user.email, subject: "Your account created successfully.")
    end

    def new_user_admin_email
        @user = User.find_by(superadmin_role: true,supervisor_role: true)
        binding.pry
        @user_last = User.last
        mail(to: @user.email, subject: "New user signed in")
    end
end
