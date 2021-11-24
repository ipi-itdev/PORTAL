class PortalDtrUploadDetail < ApplicationRecord
	self.table_name = 'PORTAL_DTRUploadDetail_C'
	
	mount_uploader :AttachmentFile, AttachmentUploader

	validates :AttachmentFile, :Description, presence: true
end
