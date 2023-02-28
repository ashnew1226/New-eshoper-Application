class Coupon < ApplicationRecord
	has_many :coupons_useds
	has_many :orders
	has_many :users, through: :coupons_useds

end
