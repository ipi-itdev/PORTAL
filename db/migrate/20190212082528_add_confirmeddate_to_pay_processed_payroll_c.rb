class AddConfirmeddateToPayProcessedPayrollC < ActiveRecord::Migration[5.1]
  def change
    add_column :PAY_ProcessedPayroll_C, :confirmeddate, :datetime
  end
end
