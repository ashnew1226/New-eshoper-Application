# frozen_string_literal: true

# Blogs
class Blog < ApplicationRecord
  has_one_attached :image
end
