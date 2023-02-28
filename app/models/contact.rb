class Contact < ApplicationRecord
	belongs_to :user
	after_update :send_admin_response
	validates :name, :email,:message, presence: true
	validates :contact_no, length: { is: 10 }

	scope :recent_customer_queries, -> { where("DATE(created_at) = ?",Date.today) }
	scope :recent_customer_queries_admin_replied, -> { recent_customer_queries.where.not(note_admin: nil) }
	def send_admin_response
		ContactMailer.contact_admin_mail(self).deliver_now
	end
end
