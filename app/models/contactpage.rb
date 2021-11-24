class Contactpage < ApplicationRecord
	self.table_name = 'PORTAL_Contactpages_U'

	validates :name, presence: true
	validates :email, presence: true
	validates :subject, presence: true
	validates :message, presence: true
end
