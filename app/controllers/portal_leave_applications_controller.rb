class PortalLeaveApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_leave_application, only: [:show, :edit, :update, :destroy]

  def index
    @portal_leave_applications = PortalLeaveApplication.find_by_sql("select * from PORTAL_LeaveApplication_U where FilingStatusRefNo <> 3 AND IsActive = 1 AND CreatedBy = #{current_user.EmployeeRefNo}")
    @LeaveOpen = 0    
    session[:portal_leave_approval_id] = 0
  end

  def show
  end

  def new
    @portal_leave_application = PortalLeaveApplication.new
  end

  def edit
    @get_edit_id = PortalLeaveApplication.find(params[:id])
    @LeaveOpen = 1
  end

  def create
    @portal_leave_application= PortalLeaveApplication.new(portal_leave_application_params)

    respond_to do |format|
      if @portal_leave_applications.save
        format.html { redirect_to @portal_leave_application}
        format.json { render :show, status: :created, location: @portal_leave_application}
      else
        format.html { render :new }
        format.json { render json: @portal_leave_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_leave_application.update(portal_leave_application_params)
        format.html { redirect_to '/portal_leave_application', notice: 'Leave application was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_leave_application }
      else
        format.html { render :edit }
        format.json { render json: @portal_leave_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSCancel @Type = 'leave', @ID = #{@portal_leave_application.id}")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 2, @ID = #{@portal_leave_application.id}, @UserRefNo = -1, @Status = 3, @Remarks = ''")

    flash[:notice] = "Record has been cancel."
    redirect_to portal_leave_applications_path
  end

  def create_leave
      portal_leave_application_save  = PortalLeaveApplication.new
      portal_leave_application_save.EmployeeRefNo = current_user.EmployeeRefNo
      portal_leave_application_save.CreatedBy = current_user.EmployeeRefNo
      portal_leave_application_save.ModifiedBy = current_user.EmployeeRefNo
      portal_leave_application_save.FilingStatusRefNo = 1
      portal_leave_application_save.ServerCompanyCodeID = '1-1'      
      portal_leave_application_save.save

      redirect_to edit_portal_leave_application_path(id: portal_leave_application_save.id)
  end

  def post_leave
    portal_leave_application_rec_checker = PortalLeaveApplication.where(ID: params[:leave_id]).pluck(:IsActive).to_sentence

    if portal_leave_application_rec_checker == 'false'
      flash[:notice] = "No details."
      redirect_to edit_portal_leave_application_path(id: params[:leave_id])

    else
      errmsg = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_PostLeaveValidation #{params[:leave_id]}")
      
      if errmsg.rows[0][0] != ''
        if @LeaveOpen == 1
          flash[:notice] = errmsg.rows[0][0]
          redirect_to edit_portal_leave_application_path(id: params[:leave_id])
        else
          flash[:notice] = errmsg.rows[0][0]
          redirect_to portal_leave_applications_path
        end
        
      else    
        portal_leave_application_rec = PortalLeaveApplication.where(ID: params[:leave_id])
      
        portal_leave_application_rec.each do |portal_leave_application_rec1|
          portal_leave_application_rec1.FilingStatusRefNo = 40
          portal_leave_application_rec1.save
        end

        #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSPost @Type = 'leave', @ID = #{params[:leave_id]}")
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 2, @ID = #{params[:leave_id]}, @UserRefNo = -1, @Status = 40, @Remarks = ''")

        flash[:notice] = "Record has been requested."
        redirect_to portal_leave_applications_path
      end
    end
  end

  private
    def set_portal_leave_application
      @portal_leave_application = PortalLeaveApplication.find(params[:id])
    end

    def portal_leave_application_params
      params.fetch(:portal_leave_application, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :Remarks)
    end
end