class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :initailize_session
  before_action :load_cart
  before_action :cms_data
  before_action :configure_permitted_parameters, if: :devise_controller?

  def cms_data
    @cms = ContentManagementSystem.last
  end
  private
  
  def initailize_session
    session[:cart] ||= []
  end
  
  def load_cart
    @cart = Product.find(session[:cart]) rescue nil
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
  end
  
end
