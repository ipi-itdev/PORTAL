class PortalLeaveApplicationDetail < ApplicationRecord
	self.table_name = 'PORTAL_LeaveApplicationDetails_C'

	mount_uploader :AttachmentFile, AttachmentUploader

	validates :WorkDate, :LeaveTypeRefNo, :LeaveCreditTypeRefNo, :Reason, presence: true

	validate :CheckLeave, on: :create
	validate :CheckLeaveEdit, on: :update
	
	def id
		read_attribute(:ID)
	end

	def leaveapplicationrefno
		read_attribute(:LeaveApplicationRefNo)
	end

	def leavetyperefno
		read_attribute(:LeaveTypeRefNo)
	end

	def leavecredittyperefno
		read_attribute(:LeaveCreditTypeRefNo)
	end

	def workdate
		read_attribute(:WorkDate)
	end

	def assl
		read_attribute(:AsSL)
	end

	def createdby
		read_attribute(:CreatedBy)
	end

	def CheckLeave
		if workdate.blank? == false
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_LeaveValidation(0, #{leaveapplicationrefno}, #{createdby}, '#{workdate.to_date}', #{leavecredittyperefno}, #{leavetyperefno}, '#{assl}')")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end

	def CheckLeaveEdit
		if workdate.blank? == false		
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_LeaveValidation(#{id}, #{leaveapplicationrefno}, #{createdby}, '#{workdate.to_date}', #{leavecredittyperefno}, #{leavetyperefno}, '#{assl}')")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end
end