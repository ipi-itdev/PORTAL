class Knowledgebase < ApplicationRecord
	self.table_name = 'PORTAL_Knowledgebases_U'

	def self.search(search)
	  where("article LIKE ?", "%#{search}%")   
	end
end
