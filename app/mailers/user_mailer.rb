class UserMailer < ApplicationMailer

    def new_user_email(user)
        @user = user
        mail(to: @user.email, subject: "Your account created successfully.")
    end

    def new_user_admin_email
        @user = User.find_by(superadmin_role: true,supervisor_role: true)
        @user_last = User.last
        mail(to: @user.email, subject: "New user signed in")
    end
    def weekly_wishlist
        @admin = User.find_by(superadmin_role: true,supervisor_role: true)
        @total_products = Wishlist.where(created_at: (Time.now.midnight - 7.day)..Time.now.midnight) 
        mail(to: @admin.email, subject: "weekly wishlist report.")
    end
end
