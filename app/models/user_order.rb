class UserOrder < ApplicationRecord
    has_many :order_details
    belongs_to :coupon, optional: true
    belongs_to :user
    # belongs_to :user_address
    # belongs_to :billing_address, :class_name => 'UserAddress', :foreign_key => 'billing_address_id'
    # belongs_to :shipping_address, :class_name => 'UserAddress', :foreign_key => 'shipping_address_id'
    # belongs_to :billing_address, :class_name => "UserAddress"
    # belongs_to :shipping_address, :class_name => "UserAddress"
  end
