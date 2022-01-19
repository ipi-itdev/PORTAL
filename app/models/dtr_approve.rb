class DtrApprove < ApplicationRecord
	self.table_name = 'ViewApproverDTR'

	default_scope { order(WorkDate: :asc) }	
end
