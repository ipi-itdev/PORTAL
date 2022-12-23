class PortalHomeposterU < ApplicationRecord
	self.table_name = 'PORTAL_HomePoster_U'

	validates :StartDate, :EndDate, presence: true

	validate :check_start_end_date, on: :update


	def start_date
		read_attribute(:StartDate)
	end

	def end_date
		read_attribute(:EndDate)
	end

	def homeposterrefno
		read_attribute(:HomePosterRefno)
	end


	def check_start_end_date
		if start_date > end_date
			errors[:base] << "Star Date is greater than End Date"
		end
	end



end
