class PortalOtApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_ot_approval, only: [:edit]

  def index
    session[:portal_ot_application_id] = nil
    session[:portal_ot_approval_id] =  nil
    @portal_ot_approvals = PortalOtApplication.find_by_sql("select * from dbo.PORTAL_OtApprover(#{current_user.EmployeeRefNo})")
  end

  def edit
    @get_edit_id = PortalOtApplication.find(params[:id])
    @otapproval = 1
  end

  def approve_ot
    #ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_SP_PortalApprovals #{current_user.EmployeeRefNo}, #{params[:ot_id]}, 2, 1, '#{@portal_ot_approval.Reason}'")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 3, @ID = #{params[:ot_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 40, @Remarks = ''")

    flash[:notice] = "Application approved."
    redirect_to portal_ot_approvals_path
  end

  def disapprove_ot
    if params[:Reason].blank? == true
      flash[:notice] = "Remarks is required."
      redirect_to edit_portal_ot_approval_path(id: params[:ot_id])
    else
      if params[:ot_status].to_i == 1
        #ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_SP_PortalApprovals #{current_user.EmployeeRefNo}, #{params[:ot_id]}, 2, 2, '#{@portal_ot_approval.Reason}'")
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 3, @ID = #{params[:ot_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 8, @Remarks = '#{params[:Reason].sub("'","''")}'")

        flash[:notice] = "Application disapproved."
        redirect_to portal_ot_approvals_path
      else        
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 3, @ID = #{params[:ot_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 1, @Remarks = '#{params[:Reason].sub("'","''")}'")

        flash[:notice] = "Application back to requestor."
        redirect_to portal_ot_approvals_path
      end 
    end
  end  

  private
    def set_portal_ot_approval
      @portal_ot_approval = PortalOtApplication.find(params[:id])
    end

    def portal_ot_approval_params
      params.fetch(:portal_ot_approval, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :Reason)
    end
end