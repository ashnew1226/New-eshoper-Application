class UserOrder < ApplicationRecord
    has_many :order_details
    has_many :products, through: :order_details
    belongs_to :coupon, optional: true
    belongs_to :user
    enum order_status: { pending: 0, failed: 1, paid: 2, stripe_executed: 3, ordered: 4}
    enum payment_gateway: { stripe: 0, paypal: 1 }

    after_update :sent_status_mail
    # belongs_to :user_address
    # belongs_to :billing_address, :class_name => 'UserAddress', :foreign_key => 'billing_address_id'
    # belongs_to :shipping_address, :class_name => 'UserAddress', :foreign_key => 'shipping_address_id'
    # belongs_to :billing_address, :class_name => "UserAddress"
    # belongs_to :shipping_address, :class_name => "UserAddress"
    def set_paid
      self.order_status = UserOrder.order_statuses[:paid]
    end
    def set_order
      self.order_status = UserOrder.order_statuses[:ordered]
    end
    def set_failed
      self.order_status = UserOrder.order_statuses[:failed]
    end
    def set_stripe_executed
      self.order_status = UserOrder.order_statuses[:stripe_executed]
    end

    def sent_status_mail
      UserOrderMailer.send_order_status(self).deliver_now
    end
  end
