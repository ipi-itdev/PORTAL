class PortalBirUploadDetail < ApplicationRecord
	self.table_name = 'PORTAL_BIR_Upload_Details'

	mount_uploader :AttachmentFile, Attachment1aUploader
	validates :AttachmentFile, presence: true


end


