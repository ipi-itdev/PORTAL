 class GenClientAccountM < ApplicationRecord
	self.table_name = 'VIEW_ClientAccount_M'

	default_scope { order(ClientAccountRefNo: :asc) }
end
