class DtrWeeklysched < ApplicationRecord
	self.table_name = 'Portal_View_DTRWeekly'

	default_scope { order(WorkDate: :asc) }	
end