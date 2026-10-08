class TreExpenseDetail < ApplicationRecord
	self.table_name = 'TRE_ExpenseDetail_U'

	mount_uploader :AttachmentFile, AttachmentUploader

	validates :EmployeeRefNo, :Amount, :AttachmentFile, presence: true
end
