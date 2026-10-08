class PayProcessedPayrollU < ApplicationRecord
	self.table_name = 'PAY_ProcessedPayroll_U'

	has_many :pay_processed_payroll_c

	def setdateformat
		 PayrollDate.to_date
	end

	default_scope { order(PayrollDate: :desc) }
	dragonfly_accessor :image	
end
