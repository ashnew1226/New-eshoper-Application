class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, :through=>:product_categories,:dependent => :destroy
    has_many :product_images
    has_many :product_attributes_assoc
    has_many :order_details


    has_one_attached :ProductImage

    
end
