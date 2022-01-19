class PortalDtrHistory < ApplicationRecord
	self.table_name = 'TMS_VIEW_DTREmployeeList'

	self.primary_key = "ID"

	default_scope { order(Description: :asc) }
end	