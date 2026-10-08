class PortalObApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_ob_application, only: [:show, :edit, :update, :destroy]

  def index
    @portal_ob_applications = PortalObApplication.find_by_sql("select * from PORTAL_OBApplication_U where FilingStatusRefNo <> 3 AND IsActive = 1 AND CreatedBy = #{current_user.EmployeeRefNo}")
    @OBOpen = 0
  end

  def show
  end

  def new
    @portal_ob_application = PortalObApplication.new
  end

  def edit
    @get_edit_id = PortalObApplication.find(params[:id])
    @OBOpen = 1
  end

  def create
    @portal_ob_application= PortalObApplication.new(portal_ob_application_params)

    respond_to do |format|
      if @portal_ob_applications.save
        format.html { redirect_to @portal_ob_application}
        format.json { render :show, status: :created, location: @portal_ob_application}
      else
        format.html { render :new }
        format.json { render json: @portal_ob_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_ob_application.update(portal_ob_application_params)

        format.html { redirect_to '/portal_ob_application', notice: 'OB Applicaion was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_ob_application }
      else
        format.html { render :edit }
        format.json { render json: @portal_ob_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSCancel @Type = 'ob', @ID = #{@portal_ob_application.id}")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 4, @ID = #{@portal_ob_application.id}, @UserRefNo = -1, @Status = 3, @Remarks = ''")

    flash[:notice] = "Record has been canceled."
    redirect_to portal_ob_applications_path
  end

  def create_ob
      portal_ob_application_save  = PortalObApplication.new
      portal_ob_application_save.EmployeeRefNo = current_user.EmployeeRefNo
      portal_ob_application_save.CreatedBy = current_user.EmployeeRefNo
      portal_ob_application_save.ModifiedBy = current_user.EmployeeRefNo
      portal_ob_application_save.FilingStatusRefNo = 1
      portal_ob_application_save.ServerCompanyCodeID = '1-1'      
      portal_ob_application_save.save

      redirect_to edit_portal_ob_application_path(id: portal_ob_application_save.id)
  end

  def post_ob
    portal_ob_application_rec_checker = PortalObApplication.where(ID: params[:ob_id]).pluck(:IsActive).to_sentence

    if portal_ob_application_rec_checker == 'false'
      flash[:notice] = "No details."
      redirect_to edit_portal_ob_application_path(id: params[:ob_id])
      
    else
      errmsg = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_PostOBValidation #{params[:ob_id]}")
      
      if errmsg.rows[0][0] != ''
        if @OBOpen == 1
          flash[:notice] = errmsg.rows[0][0]
          redirect_to edit_portal_ob_application_path(id: params[:ob_id])
        else
          flash[:notice] = errmsg.rows[0][0]
          redirect_to portal_ob_applications_path
        end
      
      else
        portal_ob_application_rec = PortalObApplication.where(ID: params[:ob_id])
      
        portal_ob_application_rec.each do |portal_ob_application_rec1|
          portal_ob_application_rec1.FilingStatusRefNo = 40
          portal_ob_application_rec1.save
        end

        #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSPost @Type = 'ob', @ID = #{params[:ob_id]}")
        ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 4, @ID = #{params[:ob_id]}, @UserRefNo = -1, @Status = 40, @Remarks = ''")

        flash[:notice] = "Record has been requested."
        redirect_to portal_ob_applications_path
      end
    end
  end

  private    
    def set_portal_ob_application
      @portal_ob_application = PortalObApplication.find(params[:id])
    end

    def portal_ob_application_params
      params.fetch(:portal_ob_application, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :Remarks)
    end
end