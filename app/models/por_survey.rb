class PorSurvey < ApplicationRecord
	self.table_name = 'PORTAL_Surveys_U'
	
	validates :answer,:SupportRating,:presence => true
end
