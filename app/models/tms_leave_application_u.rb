class TmsLeaveApplicationU < ApplicationRecord
	#self.table_name = 'TMS_LeaveApplication_U'
	self.table_name = 'TMS_VW_LeaveHistory'

	default_scope { order(WorkDate: :desc) }
end


