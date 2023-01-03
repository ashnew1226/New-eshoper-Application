class Product < ApplicationRecord
    # monetize :price_cents
    # composed_of :price,
    #           :class_name => 'Money',
    #           :mapping => %w(price cents),
    #           :converter => Proc.new { |value| Money.new(value) }
    has_many :product_categories
    has_many :categories, :through=>:product_categories,:dependent => :destroy
    has_many :product_images
    has_many :product_attributes_assoc
    has_many :order_details
    has_many :user_orders, through: :order_details
    has_many :wishlists
    has_many :users, through: :wishlists

    has_one_attached :ProductImage

    
end
