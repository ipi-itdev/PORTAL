class PortalDtrUploadDetail < ApplicationRecord
	self.table_name = 'PORTAL_DTRUploadDetail_C'
	
	mount_uploader :AttachmentFile, Attachment1aUploader

	validates :AttachmentFile, :Description, presence: true
end
