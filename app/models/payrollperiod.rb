class Payrollperiod < ApplicationRecord
	self.table_name = 'payrollperiod'

	default_scope { order(PayDate: :desc) }
end
