# frozen_string_literal: true

# coupons
class Coupon < ApplicationRecord
  has_many :coupons_useds
  has_many :orders, dependent: :destroy
  has_many :users, through: :coupons_useds, dependent: :destroy
end
