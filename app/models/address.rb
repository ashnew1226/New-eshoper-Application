class Address < ApplicationRecord
	belongs_to :user
	has_many :orders

	validates :shipping_address,:city,:country,:state,:zipcode, presence: true
	validates :zipcode, numericality: { only_integer: true }
	scope :recent, ->(value) {last(value)}

end
