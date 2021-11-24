class PortalObApplicationDetail < ApplicationRecord
	self.table_name = 'PORTAL_OBApplicationDetails_C'

	validates :WorkDate, :ClientAccountRefNo, :StartTime, :EndTime, :Task, presence: true

	validate :CheckOB, on: :create
	validate :CheckOBEdit, on: :update

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

	def CheckOB
		if workdate.blank? == false
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_OBValidation(0, #{createdby}, '#{workdate.to_date}', '#{starttime.to_s}', '#{endtime.to_s}')")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end

	def CheckOBEdit
		if workdate.blank? == false
			errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_OBValidation(#{id}, #{createdby}, '#{workdate.to_date}', '#{starttime.to_s}', '#{endtime.to_s}')")

			if errmsg.rows[0][0] != ''
				errors[:base] << errmsg.rows[0][0]
			end
		end
	end
end
