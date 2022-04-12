class PortalObApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_ob_approval, only: [:edit]

  def index
    @portal_ob_approvals = PortalObApplication.find_by_sql("select * from dbo.PORTAL_ObApprover(#{current_user.EmployeeRefNo})")
  end

  def edit
    @get_edit_id = PortalObApplication.find(params[:id])
    @obApproval = 1
  end

  def approve_ob
    #ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_SP_PortalApprovals #{current_user.EmployeeRefNo}, #{params[:ob_id]}, 2, 1, '#{@portal_ob_approval.Reason}'")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 4, @ID = #{params[:ob_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 40, @Remarks = ''")

    flash[:notice] = "Application approved."
    redirect_to portal_ob_approvals_path
  end

  def disapprove_ob
    if params[:Reason].blank? == true
      flash[:notice] = "Remarks is required."
      redirect_to edit_portal_ob_approval_path(id: params[:ob_id])
    else
      if params[:ob_status].to_i == 1
        #ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_SP_PortalApprovals #{current_user.EmployeeRefNo}, #{params[:ob_id]}, 2, 2, '#{@portal_ob_approval.Reason}'")
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 4, @ID = #{params[:ob_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 8, @Remarks = '#{params[:Reason].sub("'","''")}'")

        flash[:notice] = "Application disapproved."
        redirect_to portal_ob_approvals_path
      else        
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 4, @ID = #{params[:ob_id]}, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 1, @Remarks = '#{params[:Reason].sub("'","''")}'")

        flash[:notice] = "Application back to requestor."
        redirect_to portal_ob_approvals_path
      end 
    end
  end  

  private
    def set_portal_ob_approval
      @portal_ob_approval = PortalObApplication.find(params[:id])
    end

    def portal_ob_approval_params
      params.fetch(:portal_ob_approval, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :Reason)
    end
end