class Contact < ApplicationRecord
	belongs_to :user
	after_update :send_admin_response
	validates :name, :email,:message, presence: true
	validates :contact_no, length: { is: 10 }
	
	def send_admin_response
		ContactMailer.contact_admin_mail(self).deliver_now
	end
end
