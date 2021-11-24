class ViewConvertPortalDhsEmployeeWeeklyScheduleU < ApplicationRecord
	self.table_name = 'View_Convert_PORTAL_DHSEmployeeWeeklySchedule_U'
	default_scope { order(WorkDate: :asc) }
end
