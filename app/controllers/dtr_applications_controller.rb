class DtrApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dtr_application, only: [:edit]

  def index
    @dtr_applications = DtrApplication.find_by_sql("select * from dbo.TMS_FN_DTRApprovalPortal(#{current_user.EmployeeRefNo})")
    session[:set_base_dtr_approval_id] = ''
    session[:set_base_emprefno] = ''
  end

  def edit
    @get_dtr_app_id = DtrApplication.find(params[:id])  
    @dtrpayroll = DtrApplication.where(ID: params[:id]).pluck(:PayrollDate)
    @dtr_upload = PortalDtrUpload.where(EmployeeRefNo: params[:id], PayrollDate: @dtrpayroll).pluck(:ID).to_sentence  
    session[:portal_dtr_upload_id] = @dtr_upload
    session[:portal_dtrupload_isadd] = 0
  end

  def approve_dtr
    #ActiveRecord::Base.connection.exec_query("EXEC dbo.TMS_SP_PortalDTRApproval #{current_user.EmployeeRefNo}, #{params[:dtr_id]}, #{params[:dtr_employee]}")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 1, @ID =  #{params[:dtr_detail_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 40, @Remarks = ''")
    
    flash[:notice] = "Application appxroved."
    redirect_to dtr_applications_path
  end

  def back_dtr
    if params[:Remarks].blank? == true
      flash[:notice] = "Remarks is required."
      redirect_to edit_dtr_application_path(params[:dtr_application_employeerefno])
    else
    #ActiveRecord::Base.connection.exec_query("EXEC dbo.TMS_SP_PortalDTRApproval #{current_user.EmployeeRefNo}, #{params[:dtr_id]}, #{params[:dtr_employee]}")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 1, @ID =  #{params[:dtr_detail_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 1, @Remarks = '#{params[:Remarks].sub("'","''")}'")
    
    flash[:notice] = "Returned to employee successfully."
    redirect_to dtr_applications_path
    end
  end

  private
    def set_dtr_application
      @dtr_application = DtrApplication.find(params[:id])
    end

    def dtr_application_params
      params.fetch(:dtr_application, {}).permit(:ID, :DTRApplication, :EmployeeRefNo, :EmployeeNumber, :Description, :JobPosition, :UserRefNo)
    end
end

