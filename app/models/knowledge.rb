class Knowledge < ApplicationRecord
	validates :title , :presence => true
	validates :summary , :presence => true

	default_scope { order(created_at: :desc) }

	mount_uploader :attachment, AttachmentUploader
end
