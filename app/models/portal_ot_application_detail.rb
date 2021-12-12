class PortalOtApplicationDetail < ApplicationRecord
	self.table_name = 'PORTAL_OvertimeApplicationDetails_C'

	mount_uploader :AttachmentFile, AttachmentUploader
	
	validates :WorkDate, :StartTime, :EndTime, :Task, presence: true

	validate :CheckOT, on: :create
	validate :CheckOTEdit, on: :update

	def id
		read_attribute(:ID)
	end

	def workdate
		read_attribute(:WorkDate)
	end

	def starttime
		read_attribute(:StartTime)
	end

	def endtime
		read_attribute(:EndTime)
	end

	def createdby
		read_attribute(:CreatedBy)
	end

	def CheckOT
		if workdate.blank? == false 
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_OTValidation(0, #{createdby}, '#{workdate.to_date}', '#{starttime.to_s}', '#{endtime.to_s}')")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end

	def CheckOTEdit
		if workdate.blank? == false 
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_OTValidation(#{id}, #{createdby}, '#{workdate.to_date}', '#{starttime.to_s}', '#{endtime.to_s}')")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end
end
