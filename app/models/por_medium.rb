class PorMedium < ApplicationRecord
	self.table_name = 'PORTAL_Media_U'

	validates :title,:description,:mediapath,:presence => true

	validates :title, length: { minimum: 1, maximum: 200 }
	validates :description,length: { minimum: 10, maximum: 100000 }
	validates :mediapath,length: { minimum: 10, maximum: 100000 }

	validates :media_seq_refno, uniqueness: { 
    message: "Sequence already exist" }
end
