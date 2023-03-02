# frozen_string_literal: true

# wishlists
class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
