class PortalVacsurveyU < ApplicationRecord
	self.table_name = 'PORTAL_VacSurvey_U'

	#validate :check_reason_on_no, on: :create

	def check_reason_on_no
		if  answer == 1 && reason ==''
		 	errors[:base] << "Please enter your reason"
		end 
	end	
end
