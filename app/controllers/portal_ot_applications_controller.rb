class PortalOtApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_ot_application, only: [:show, :edit, :update, :destroy]

  def index
    #@portal_ot_applications = ActiveRecord::Base.connection.exec_query("Select * from dbo.VW_PORTAL_OvertimeApplication WHERE CreatedBy = #{current_user.EmployeeRefNo}")
    session[:portal_ot_application_id] = nil
    session[:portal_ot_approval_id] =  nil
    @portal_ot_applications = PortalOtApplication.find_by_sql("select * from PORTAL_OvertimeApplication_U where FilingStatusRefNo <> 3 AND IsActive = 1 AND CreatedBy = #{current_user.EmployeeRefNo}")
    @OTOpen = 0
  end

  def show
  end

  def new
    @portal_ot_application = PortalOtApplication.new
  end
  
  def edit
    @get_edit_id = PortalOtApplication.find(params[:id])
    @OTOpen = 1
  end

  def create
    @portal_ot_application= PortalOtApplication.new(portal_ot_application_params)

    respond_to do |format|
      if @portal_ot_applications.save
        format.html { redirect_to @portal_ot_application}
        format.json { render :show, status: :created, location: @portal_ot_application}
      else
        format.html { render :new }
        format.json { render json: @portal_ot_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_ot_application.update(portal_ot_application_params)        
        format.html { redirect_to '/portal_ot_application', notice: 'Overtime was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_ot_application }
      else
        format.html { render :edit }
        format.json { render json: @portal_ot_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSCancel @Type = 'ot', @ID = #{@portal_ot_application.id}")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 3, @ID = #{@portal_ot_application.id}, @UserRefNo = -1, @Status = 3, @Remarks = ''")

    flash[:notice] = "Record has been canceled."
    redirect_to portal_ot_applications_path
  end

  def create_ot
      portal_ot_application_save  = PortalOtApplication.new
      portal_ot_application_save.EmployeeRefNo = current_user.EmployeeRefNo
      portal_ot_application_save.CreatedBy = current_user.EmployeeRefNo
      portal_ot_application_save.ModifiedBy = current_user.EmployeeRefNo
      portal_ot_application_save.FilingStatusRefNo = 1
      portal_ot_application_save.ServerCompanyCodeID = '1-1'      
      portal_ot_application_save.save

      redirect_to edit_portal_ot_application_path(id: portal_ot_application_save.id)
  end

  def post_ot
    portal_ot_application_rec_checker = PortalOtApplication.where(ID: params[:ot_id]).pluck(:IsActive).to_sentence

    if portal_ot_application_rec_checker == 'false'
      flash[:notice] = "No details."
      redirect_to edit_portal_ot_application_path(id: params[:ot_id])

    else      
      errmsg = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_PostOTValidation #{params[:ot_id]}")
      
      if errmsg.rows[0][0] != ''
        if @OTOpen == 1
          flash[:notice] = errmsg.rows[0][0]
          redirect_to edit_portal_ot_application_path(id: params[:ot_id])
        else
          flash[:notice] = errmsg.rows[0][0]
          redirect_to portal_ot_applications_path
        end
      
      else
        portal_ot_application_rec = PortalOtApplication.where(ID: params[:ot_id])
      
        portal_ot_application_rec.each do |portal_ot_application_rec1|
          portal_ot_application_rec1.FilingStatusRefNo = 40
          portal_ot_application_rec1.save
        end
  
        #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSPost @Type = 'ot', @ID = #{params[:ot_id]}")
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 3, @ID = #{params[:ot_id]}, @UserRefNo = -1, @Status = 40, @Remarks = ''")

        flash[:notice] = "Record has been requested."
        redirect_to portal_ot_applications_path
      end
    end
  end

  private    
    def set_portal_ot_application
      @portal_ot_application = PortalOtApplication.find(params[:id])
    end

    def portal_ot_application_params
      params.fetch(:portal_ot_application, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :Remarks)
    end
end