module UsersHelper
  def user_address
    current_user.addresses.last if current_user.present?
  end
end
