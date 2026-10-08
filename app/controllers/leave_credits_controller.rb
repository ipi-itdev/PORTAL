class LeaveCreditsController < ApplicationController
	before_action :authenticate_user!

  def index

  	if current_user.is_manager == true
      @getleavetype = ViewLeaveDetailsPortal.where(EmployeeRefNo: current_user.EmployeeRefNo)

      get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
      hash_get_emp_details = get_emp_details[0]
      get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first
      @get_manager_departments = GenDepartmentM.where(UserRefNo: get_manager_userrefno)

    else

      @getleavetype = ViewLeaveDetailsPortal.where(EmployeeRefNo: current_user.EmployeeRefNo)
    
    end

  end


  def dept_leave_credits

  	  get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
      hash_get_emp_details = get_emp_details[0]
      get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first
      @get_manager_departments = GenDepartmentM.where(UserRefNo: get_manager_userrefno)

  end


end
