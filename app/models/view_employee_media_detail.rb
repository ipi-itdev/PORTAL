class ViewEmployeeMediaDetail < ApplicationRecord
	self.table_name = 'view_employee_media_details'

	default_scope { order(media_seq_refno: :asc) }	
end
