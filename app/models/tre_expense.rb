class TreExpense < ApplicationRecord
	self.table_name = 'TRE_Expense_U'
	validates :Date, :Description, :presence => true, on: :update
end
