# frozen_string_literal: true

# order details
class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order
end
