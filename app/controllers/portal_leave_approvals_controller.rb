class PortalLeaveApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_leave_approval, only: [:edit]

  def index
    @portal_leave_approvals = PortalLeaveApplication.find_by_sql("select * from dbo.PORTAL_LeaveApprover(#{current_user.EmployeeRefNo})")    
    session[:portal_leave_application_id] = 0
  end

  def edit
    @get_edit_id = PortalLeaveApplication.find(params[:id])
    @leaveapproval = 1
  end

  def approve_leave
    #ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_SP_PortalApprovals #{current_user.EmployeeRefNo}, #{params[:leave_id]}, 3, 1, '#{params[:Reason]}'")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 2, @ID = #{params[:leave_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 40, @Remarks = ''")

    flash[:notice] = "Application approved."
    redirect_to portal_leave_approvals_path
  end

  def disapprove_leave    
    if params[:Reason].blank? == true
      flash[:notice] = "Remarks is required."
      redirect_to edit_portal_leave_approval_path(id: params[:leave_id])
    else
      if params[:leave_status].to_i == 1
        #ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_SP_PortalApprovals #{current_user.EmployeeRefNo}, #{params[:leave_id]}, 3, 2, '#{params[:Reason]}'")
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 2, @ID = #{params[:leave_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 8, @Remarks = '#{params[:Reason].sub("'","''")}'")

        flash[:notice] = "Application disapproved."
        redirect_to portal_leave_approvals_path
      else
        #ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_SP_PortalApprovals #{current_user.EmployeeRefNo}, #{params[:leave_id]}, 3, 2, '#{params[:Reason]}'")
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 2, @ID = #{params[:leave_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 1, @Remarks = '#{params[:Reason].sub("'","''")}'")

        flash[:notice] = "Application back to requestor."
        redirect_to portal_leave_approvals_path
      end
    end
  end  

  private
    def set_portal_leave_approval
      @portal_leave_approval = PortalLeaveApplication.find(params[:id])
    end

    def portal_leave_approval_params
      params.fetch(:portal_leave_approval, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :Reason)
    end
end