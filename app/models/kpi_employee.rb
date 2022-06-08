class KpiEmployee < ApplicationRecord
	self.table_name = 'EmployeeWithNA'

	default_scope { order(LastName: :asc) }
end