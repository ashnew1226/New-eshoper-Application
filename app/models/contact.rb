class Contact < ApplicationRecord
    after_update :send_admin_responce

    def send_admin_responce
        ContactMailer.contact_admin_mail(self).deliver_now
    end
end
