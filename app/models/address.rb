# frozen_string_literal: true

# This is Address model.
class Address < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  validates :shipping_address, :city, :country, :state, :zipcode, presence: true
  validates :zipcode, numericality: { only_integer: true }
  scope :recent, ->(value) { last(value) }
end
