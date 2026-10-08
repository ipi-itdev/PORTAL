class Payrollperiodexternal < ApplicationRecord
	self.table_name = 'payrollperiodexternal'

	default_scope { order(PayDate: :desc) }
end
