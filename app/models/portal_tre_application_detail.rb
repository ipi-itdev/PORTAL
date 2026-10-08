class PortalTreApplicationDetail < ApplicationRecord
	self.table_name = 'PORTAL_TREApplicationDetails_C'

	mount_uploader :AttachmentFile, AttachmentUploader

	HUMANIZED_ATTRIBUTES = {
		:WorkDate => "Date",
		:AttachmentFile => "Attach File"
	}

	def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end

	validates :WorkDate, :EntryRefNo, :ClientAccountRefNo, :AttachmentFile, presence: true

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
		if amount == nil
			errors[:base] << "Amount is required."

		elsif workdate.blank? == false 
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_TREValidation(0, #{createdby}, #{clientaccountrefno}, '#{workdate.to_date}', #{entryrefno}, #{amount})")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end

	def ValidateEdit
		if amount == nil
			errors[:base] << "Amount is required."

		elsif workdate.blank? == false 
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_TREValidation(#{id}, #{createdby}, #{clientaccountrefno}, '#{workdate.to_date}', #{entryrefno}, #{amount})")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end
end