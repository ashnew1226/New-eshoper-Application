# frozen_string_literal: true

# products
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook github]
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :coupons_useds, dependent: :destroy
  has_many :coupons, through: :coupons_useds
  has_many :wishlists, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :products, through: :wishlists
  has_one_attached :image
  after_create :user_email, :admin_email
  validates :firstname, presence: { message: 'first name is required.' }
  validates :lastname, presence: { message: 'last name is required.' }
  scope :admin, -> { find_by(superadmin_role: true, supervisor_role: true) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user_email = auth.info.email.present? ? auth.info.email : "user.#{auth.uid}@gmail.com"
      user.email = user_email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def user_email
    UserMailer.new_user_email(self).deliver_now
  end

  def admin_email
    UserMailer.new_user_admin_email.deliver_now
  end
end
