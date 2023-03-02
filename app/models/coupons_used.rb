# frozen_string_literal: true

# used coupons
class CouponsUsed < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
end
