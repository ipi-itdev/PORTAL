class PortalSurveyCovid19 < ApplicationRecord
	validates :q1_0, :q1_1, :q2_0, :q3_0, :q5_0,:q6_0,:q7_0, :presence => true
end
