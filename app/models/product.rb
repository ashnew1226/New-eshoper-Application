class Product < ApplicationRecord

	has_many :product_categories
	has_many :categories, through: :product_categories,dependent: :destroy
	has_many :product_images
	has_many :product_attributes_assoc
	has_many :order_details
	has_many :orders, through: :order_details
	has_many :wishlists
	has_many :users, through: :wishlists

	has_one_attached :ProductImage
	validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  scope :costs_less_than, ->(price) { where("price < ?", price) }
  scope :costs_more_than, ->(price) { where(" price > ?", price) }
	scope :recent, -> (value) { where("created_at") }
  # scope :cost_between, ->(low_price, high_price){where(price: low_price..high_price)}

	def self.filter(cost)
		# binding.pry
		if cost[:option].present? && cost[:dec_option].present?
			# a = self.costs_less_than(cost[:option]) && self.costs_more_than_less(cost[:dec_option])
			# self.cost_between(cost[:option], cost[:dec_option])
		elsif cost[:option].present?
			self.costs_less_than(cost[:option])
		elsif cost[:dec_option].present?
			self.costs_more_than(cost[:dec_option])
		end
		# self.costs_more_than(cost) if cost[:dec_option].present?
	end

end
