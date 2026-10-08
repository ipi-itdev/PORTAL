class PisauditController < ApplicationController
	before_action :authenticate_user!
	prepend_before_action :check_current_user


	def pisaudit

		if current_user.done_pisaudit == true
			redirect_to pages_path
		else
			@pisaudit_link = "https://pis.ipiphil.com/?pkey=3_#{current_user.EmployeeRefNo}"			
		end

  	end

  	

  	def ans_pis_later

	    user = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
	    user.update(answer_pis_later: 1)
	    redirect_to pages_path
  		
  	end



	private
	def check_current_user

	  if user_signed_in? == true
	    #nothing to do
	  else
	    flash[:notice] = 'Session ended, Please try to login.'
	    redirect_to '/'
	  end
	  
	end



end

