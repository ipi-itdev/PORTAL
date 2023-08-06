class PortalTempwebinar < ApplicationRecord
	validates :answer, presence: true
	#validates :Email, presence: true, 'valid_email_2/email': true
end
