class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cache_buster



  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path

  end

  #added this on 
  private
  def after_sign_in_path_for(resource_or_scope)
    #update last log-in
    user = User.find_by(EmployeeRefNo: current_user.EmployeeRefNo)
    user.update(datelastlogin: Time.now)

    #get if resigned
    getlastest_PisEmploymentInfoU1 = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:EmployeeStatusRefNo)
    getlastest_PisEmploymentInfoU = getlastest_PisEmploymentInfoU1[0]
    session[:currentuser_employeestatusrefno] = getlastest_PisEmploymentInfoU[:EmployeeStatusRefNo]

    
    #check if empposter rec exist
    check_exist_empposter = PortalEmpposterDetail.where(employeerefno: current_user.EmployeeRefNo).exists?
    if check_exist_empposter == false
      user = PortalEmpposterDetail.create(employeerefno: current_user.EmployeeRefNo, created_at: Time.now, updated_at: Time.now )
      user.save
    end
    #check if empposter rec exist

    
    if session[:currentuser_employeestatusrefno] == 2

      pay_processed_payroll_us_path

    else

      pages_path

    end   

  end

  # add for previous page issue when user tried to clicked the prev button.
  private
  def set_cache_buster
  response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  response.headers["Pragma"] = "no-cache"
  response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

    
  protected
  def configure_permitted_parameters
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:EmployeeNumber,:username,:email,:image, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:EmployeeNumber])
    devise_parameter_sanitizer.permit(:account_update, keys: [:EmployeeNumber, :image])
  end

end
