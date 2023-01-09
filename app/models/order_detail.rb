class OrderDetail < ApplicationRecord
    belongs_to :product
    belongs_to :user_order
end
