class PortalPoster < ApplicationRecord
	mount_uploader :attachedfile, AttachmentUploader
end
