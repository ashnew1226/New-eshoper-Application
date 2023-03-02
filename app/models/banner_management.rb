# frozen_string_literal: true

# Banner Management
class BannerManagement < ApplicationRecord
  has_many_attached :picture
end
