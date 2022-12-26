class UserAddress < ApplicationRecord
    # has_many :user_orders
    belongs_to :user
    self.primary_key = 'id'
end
