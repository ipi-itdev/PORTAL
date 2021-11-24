class PorTempSurvey < ApplicationRecord
	self.table_name = 'PORTAL_Temp_Surveys_U'
	
	validates :Q1,:Q2,:Q3,:Q4,:Q5,:Q6,:Q7,:Q8,:Q9,:Q10,:Q11,:Q12,:Q13,:Q14,:Q15,:presence => true
end
