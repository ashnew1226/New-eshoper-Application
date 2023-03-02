app/models/product_attributes_assoc.rb# frozen_string_literal: true

# Blogs
class ProductCategory < ApplicationRecord
  belongs_to :category
  belongs_to :product
end
