class ViewPortalUploadedBirForm < ApplicationRecord

	self.table_name = 'VIEW_PORTAL_UPLOADED_BIR_FORM'

	mount_uploader :AttachmentFile, Attachment1aUploader
	
end


