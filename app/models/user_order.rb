class UserOrder < ApplicationRecord
    has_many :order_details
    has_many :products, through: :order_details
    belongs_to :coupon, optional: true
    belongs_to :user
    enum status: { pending: 0, failed: 1, paid: 2, paypal_executed: 3}
    enum payment_gateway: { stripe: 0, paypal: 1 }
    # belongs_to :user_address
    # belongs_to :billing_address, :class_name => 'UserAddress', :foreign_key => 'billing_address_id'
    # belongs_to :shipping_address, :class_name => 'UserAddress', :foreign_key => 'shipping_address_id'
    # belongs_to :billing_address, :class_name => "UserAddress"
    # belongs_to :shipping_address, :class_name => "UserAddress"
    def set_paid
      self.status = Order.statuses[:paid]
    end
    def set_failed
      self.status = Order.statuses[:failed]
    end
    def set_paypal_executed
      self.status = Order.statuses[:paypal_executed]
    end
  end
