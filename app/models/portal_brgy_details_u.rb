class PortalBrgyDetailsU < ApplicationRecord

		self.table_name = 'PORTAL_Brgy_Details_U'

		validates :BrgyContactNum, presence: true, length: { minimum: 1, maximum: 20 }


end
