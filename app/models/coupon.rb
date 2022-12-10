class Coupon < ApplicationRecord
    has_many :coupons_useds
    has_many :users, through: :coupons_useds

    # enum :status, [ :active, :inactive]


end
