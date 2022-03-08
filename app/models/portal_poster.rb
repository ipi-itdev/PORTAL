class PortalPoster < ApplicationRecord
	validates :description, :start_date, :attachedfile, presence: true
	mount_uploader :attachedfile, AttachmentUploader
end
