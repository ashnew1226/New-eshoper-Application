class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers=> [:google_oauth2, :facebook, :github]
  has_many :user_orders
  has_many :user_addresses
  has_many :coupons_useds
  has_many :coupons, through: :coupons_useds
  has_many :wishlists
  has_many :products, through: :wishlists
  has_one_attached :image
  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user_email = auth.info.email.present? ? auth.info.email : "user.#{auth.uid}@gmail.com"
      user.email = user_email
      user.password = Devise.friendly_token[0, 20]
      
    end
  end
end
