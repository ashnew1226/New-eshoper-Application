# frozen_string_literal: true

# contacts
class Contact < ApplicationRecord
  belongs_to :user
  after_update :send_admin_response
  validates :message, presence: true
  validates :contact_no, length: { is: 10 }
  scope :recent_customer_queries, -> { where('DATE(created_at) = ?', Date.today) }
  scope :recent_replied_queries, -> { recent_customer_queries.where('note_admin IS NOT NULL') }
  def send_admin_response
    ContactMailer.contact_admin_mail(self).deliver_now
  end
end
