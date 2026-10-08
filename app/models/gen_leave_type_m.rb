class GenLeaveTypeM < ApplicationRecord
	self.table_name = 'gen_leavetype_m'
	default_scope { order(Description: :asc) }
end
