class UserAddress < ApplicationRecord
    # has_many :user_orders
    belongs_to :user
    has_many :user_orders
    self.primary_key = 'id'

    validates :shipping_address,:city,:country,:state,:zipcode, presence: true
    validates :zipcode, numericality: { only_integer: true }

end
