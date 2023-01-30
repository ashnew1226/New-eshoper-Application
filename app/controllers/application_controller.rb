class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :initailize_session
    before_action :load_cart
    before_action :cms_data
    before_action :configure_permitted_parameters, if: :devise_controller?
    private

    def initailize_session
        session[:cart] ||= [] # empty cart = empty array
    end

    def load_cart
        @cart = Product.find(session[:cart]) rescue nil
        @cart_quantity = session[:cart_quantity]
    end
    
    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
  end
  def cms_data
    @cms = ContentManagementSystem.last
  end
  
end
