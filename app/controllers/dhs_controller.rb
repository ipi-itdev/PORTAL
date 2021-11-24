class DhsController < ApplicationController
	before_action :authenticate_user!
	prepend_before_action :check_current_user

	def ODHD		
		##old
		#@ODHD_link = "https://dhs.ipiphil.com/#?pkey=3_#{current_user.EmployeeRefNo}_0"	
		#@ODHD_link = "https://aaigcat-001-site9.htempurl.com/#?pkey=1_1_0"	
		@ODHD_link = "https://dhs.pitsph.com/#?pkey=1_#{current_user.EmployeeRefNo}_0"

		@weeksched = PortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1)
	end

	def BRGY	
		@companycode = GenCompanyM.where(IsActive: 1).pluck(:Code).to_sentence
		
		@BRGY_link = "https://brgyhotlines.pitsph.com/#?pkey=#{@companycode}_#{current_user.EmployeeRefNo}"		
	end

	private
	def check_current_user
	  if user_signed_in? == false
	    flash[:notice] = 'Session ended, Please try to login.'
	    redirect_to '/'
	  end
	end
end
