class Payrollperiodinternal < ApplicationRecord
	self.table_name = 'payrollperiodinternal'

	default_scope { order(PayDate: :desc) }
end
