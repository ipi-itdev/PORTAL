class KpiAssignment < ApplicationRecord
	self.table_name = 'PIS_KPIAssigmentDetails'

	validates :ID, :EmployeeRefNo, :EvalPurposeRefNo, :SubmissionDate, presence: true

	validate :CheckKPI, on: :update

	def id
		read_attribute(:ID)
	end

	def employeerefno
		read_attribute(:EmployeeRefNo)
	end

	def evalpurpose
		read_attribute(:EvalPurposeRefNo)
	end

	def startdate
		read_attribute(:StartDate)
	end

	def enddate
		read_attribute(:EndDate)
	end 
	
	def submissiondate
		read_attribute(:SubmissionDate)
	end

	def CheckKPI		
		errmsg = ActiveRecord::Base.connection.exec_query("Select errmsg = dbo.PORTAL_FN_KPIValidation(#{id}, #{employeerefno})")			

		if evalpurpose == 0
			errors[:base] << 'Purpose is required.'

		elsif employeerefno == 0
			errors[:base] << 'Employee is required.'
			
		elsif errmsg.rows[0][0] != ''
			errors[:base] << errmsg.rows[0][0]

		elsif startdate >= enddate
			errors[:base] << 'End date must be greater then start date'
		
		elsif enddate >= submissiondate
			errors[:base] << 'Due date must be greater then end date'
		end
	end
end