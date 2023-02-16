class UserAddress < ApplicationRecord
	belongs_to :user
	has_many :user_orders

	validates :shipping_address,:city,:country,:state,:zipcode, presence: true
	validates :zipcode, numericality: { only_integer: true }

end
