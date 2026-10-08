class GenHolidayM < ApplicationRecord
	self.table_name = 'GEN_Holiday_M'

	default_scope { order(HolidayDate: :asc) }
end
