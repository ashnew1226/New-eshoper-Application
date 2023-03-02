# frozen_string_literal: true

# model for order
class Order < ApplicationRecord
  has_many :order_details
  has_many :products, through: :order_details, dependent: :destroy
  belongs_to :address
  belongs_to :coupon, optional: true
  belongs_to :user
  enum order_status: { pending: 0, failed: 1, paid: 2, stripe_executed: 3, ordered: 4 }
  enum payment_gateway: { stripe: 0, paypal: 1 }
  after_update :sent_status_mail

  def set_paid
    self.order_status = Order.order_statuses[:paid]
  end

  def set_order
    self.order_status = Order.order_statuses[:ordered]
  end

  def set_failed
    self.order_status = Order.order_statuses[:failed]
  end

  def set_stripe_executed
    self.order_status = Order.order_statuses[:stripe_executed]
  end

  def sent_status_mail
    OrderMailer.send_order_status(self).deliver_now
  end
end
