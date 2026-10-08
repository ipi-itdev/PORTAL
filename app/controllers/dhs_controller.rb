class DhsController < ApplicationController
	before_action :authenticate_user!
	prepend_before_action :check_current_user

	def ODHD		
		@ODHD_link = "https://dhs.ipiphil.com/#?pkey=3_#{current_user.EmployeeRefNo}_0"
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
