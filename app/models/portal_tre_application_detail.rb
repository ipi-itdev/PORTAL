class PortalTreApplicationDetail < ApplicationRecord
	self.table_name = 'PORTAL_TREApplicationDetails_C'

	mount_uploader :AttachmentFile, AttachmentUploader

	validates :WorkDate, :EntryRefNo, :ClientAccountRefNo, :Amount, presence: true

	validate :Validate, on: :create
	validate :ValidateEdit, on: :update

	def amount
		read_attribute(:Amount)
	end

	def clientaccountrefno
		read_attribute(:ClientAccountRefNo)
	end

	def id
		read_attribute(:ID)
	end

	def workdate
		read_attribute(:WorkDate)
	end

	def entryrefno
		read_attribute(:EntryRefNo)
	end

	def createdby
		read_attribute(:CreatedBy)
	end

	def Validate
		if workdate.blank? == false 
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_TREValidation(0, #{createdby}, #{clientaccountrefno}, '#{workdate.to_date}', #{entryrefno}, #{amount})")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end

	def ValidateEdit
		if workdate.blank? == false 
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_TREValidation(#{id}, #{createdby}, #{clientaccountrefno}, '#{workdate.to_date}', #{entryrefno}, #{amount})")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end
end