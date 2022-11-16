class PortalDhsEmployeeWeeklyScheduleU < ApplicationRecord
	self.table_name = 'PORTAL_DHSEmployeeWeeklySchedule_U'

	default_scope { order(WorkDate: :asc) }

	#validate :check_shifts
	validate :check_null
	#validate :check_rd

	#check_shifts
	def check_shifts
		if IsRD? == false && shift_start.blank? == false && shift_end.blank? == false
			if shift_start == shift_end 
			 	errors[:base] << "Shift Start is equal to Shift End"
			end
	    end 
	end

	#check_shifts
	def check_null
		if IsRD? == false
			if shift_start.blank? == true || shift_end.blank? == true  
			 	errors[:base] << "Shift Start/End is empty"
			end
	    end 
	end

	#check_shifts
	def check_rd
		if IsRD? == false && shift_start > shift_end
			errors[:base] << "Cannot save record."
	    end 
	end
end

