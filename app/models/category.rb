# frozen_string_literal: true

# Blogs
class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories, dependent: :destroy
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true
  enum :status, %i[active inactive]
  scope :with_subcategories, -> { where('parent_id = id') }
end
