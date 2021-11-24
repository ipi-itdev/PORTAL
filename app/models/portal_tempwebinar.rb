class PortalTempwebinar < ApplicationRecord
	validates :Name, presence: true
	validates :Email, presence: true, 'valid_email_2/email': true
end
