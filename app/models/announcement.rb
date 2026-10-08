class Announcement < ApplicationRecord
	self.table_name = 'PORTAL_Announcements_U'
	validates :title, presence: true, length: { minimum: 1, maximum: 50 }
	validates :message, presence: true,length: { minimum: 10, maximum: 500 }

	default_scope { order(created_at: :desc) }
end
