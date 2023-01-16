class Contact < ApplicationRecord
    belongs_to :user
    after_update :send_admin_responce

    validates :name, :email,:message, presence: true
    # PHONE_REGEX = /\A\(\d{3}\)\d{3}-\d{4}\z/
    # validates :contact_no, format: { with: PHONE_REGEX }
    validates :contact_no, length: { is: 10 }
    def send_admin_responce
        ContactMailer.contact_admin_mail(self).deliver_now
    end
end
