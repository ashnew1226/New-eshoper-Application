class UsersController < ApplicationController
    def index
        @user_profile_image = current_user.image
    end

    def myorder
        
    end
    
end
