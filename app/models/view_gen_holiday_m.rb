class ViewGenHolidayM < ApplicationRecord
	self.table_name = 'VIEW_GEN_Holiday_M'

	default_scope { order(HolidayDate: :asc) }
end
