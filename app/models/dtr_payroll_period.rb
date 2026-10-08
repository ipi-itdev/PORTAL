class DtrPayrollPeriod < ApplicationRecord
	self.table_name = 'TMS_VIEW_GetPayrollPeriod'

	default_scope { order(PayrollDate: :desc) }
end