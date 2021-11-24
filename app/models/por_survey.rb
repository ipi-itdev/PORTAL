class PorSurvey < ApplicationRecord
	self.table_name = 'PORTAL_Surveys_U'
	
	validates :answer,:comments,:presence => true
end
