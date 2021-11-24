class UserMailer < ApplicationMailer

	default from: 'no-reply@IPIsupport.com'
 
  def welcome_email(referral, sendto)
    @referral = referral
    @sendto = sendto	

    @url  = 'http://example.com/login'
    mail(to: "vcr@ipiphil.com",cc: "jib@ipiphil.com", bcc: "ndg@ipiphil.com", subject: "IPI Employee Referral")
    #mail(to: "ndg@ipiphil.com",cc: "ndg@ipiphil.com", bcc: "finding.ned222705@gmail.com", subject: "IPI Employee Referral")
  end

  #internal submit email leave application
  def internal_leave_email(get_leave_app_submit, get_dept_manager_email, get_internal_user_email)
  	@get_leave_app_submit = get_leave_app_submit
  	@get_dept_manager_email = get_dept_manager_email
    @get_internal_user_email = get_internal_user_email
  	mail(to: @get_dept_manager_email, cc: @get_internal_user_email, bcc: "ndg@ipiphil.com",  subject: "IPI - For Approval Leave Application")
  end

  #external submit email leave application
  def external_leave_email(get_leave_app_submit, get_dept_manager_email, get_external_user_email)
    @get_leave_app_submit = get_leave_app_submit
    @get_dept_manager_email = get_dept_manager_email
    @get_external_user_email = get_external_user_email
    mail(to: "hrc@ipiphil.com",cc: "jib@ipiphil.com", bcc: "ndg@ipiphil.com", subject: "IPI - For Approval Leave Application")
    #mail(to: "hrctest@ipiphil.com",cc: @get_external_user_email, bcc: "ndg@ipiphil.com", subject: "IPI - For Approval Leave Application")
  end

  # approver approve / disapprove leave application
  def approver_submit_email(get_approver_submit_details, get_emp_email, get_approver_email)
    @get_approver_submit_details = get_approver_submit_details
    @get_emp_email = get_emp_email
    @get_approver_email = get_approver_email
    mail(to: @get_emp_email, cc: @get_approver_email, bcc: "ndg@ipiphil.com", subject: "IPI - Employee Leave Application")
    
  end

  #cancel leave application
  def cancel_application_email(get_approver_submit_details, get_previous_details, get_emp_email, get_approver_email, get_approver_submit_details_header)
    @get_approver_submit_details = get_approver_submit_details
    @get_previous_details = get_previous_details
    @get_emp_email = get_emp_email
    @get_approver_email = get_approver_email
    @get_approver_submit_details_header =  get_approver_submit_details_header
    mail(to: "hrc@ipiphil.com", :cc => [@get_emp_email, @get_approver_email] , bcc: "ndg@ipiphil.com", subject: "IPI - Cancel Leave Application")
    #mail(to: "ndg@ipiphil.com", :cc => [@get_emp_email, @get_approver_email] , bcc: "ndg@ipiphil.com", subject: "IPI - Cancel Leave Application")
  end
   
end
