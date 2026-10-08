class PortalTreApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_tre_application, only: [:show, :edit, :update, :destroy]

  def index
    @portal_tre_applications = PortalTreApplication.find_by_sql("select * from PORTAL_TreApplication_U where IsActive = 1 AND CreatedBy = #{current_user.EmployeeRefNo}")
    @TreOpen = 0
  end

  def show
  end

  def new
    @portal_tre_application = PortalTreApplication.new
  end

  def edit
    @get_edit_id = PortalTreApplication.find(params[:id])
    @TreOpen = 1
  end

  def create
    @portal_tre_application= PortalTreApplication.new(portal_tre_application_params)

    respond_to do |format|
      if @portal_tre_applications.save
        format.html { redirect_to @portal_tre_application}
        format.json { render :show, status: :created, location: @portal_tre_application}
      else
        format.html { render :new }
        format.json { render json: @portal_tre_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_tre_application.update(portal_tre_application_params)

        format.html { redirect_to '/portal_tre_application', notice: 'Tre application was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_tre_application }
      else
        format.html { render :edit }
        format.json { render json: @portal_tre_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #portal_tre_application_rec = PortalTreApplication.where(ID: @portal_tre_application.id)
     
    #portal_tre_application_rec.each do |portal_tre_application_rec1|
    #  portal_tre_application_rec1.FilingStatusRefNo = 3
    #  portal_tre_application_rec1.save
    #end

    #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSCancel @Type = 'tre', @ID = #{@portal_tre_application.id}")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 5, @ID = #{@portal_tre_application.id}, @UserRefNo = -1, @Status = 3, @Remarks = ''")

    flash[:notice] = "Record has been canceled."
    redirect_to portal_tre_applications_path
  end

  def create_tre
      portal_tre_application_save  = PortalTreApplication.new
      portal_tre_application_save.EmployeeRefNo = current_user.EmployeeRefNo
      portal_tre_application_save.CreatedBy = current_user.EmployeeRefNo
      portal_tre_application_save.ModifiedBy = current_user.EmployeeRefNo
      portal_tre_application_save.FilingStatusRefNo = 1
      portal_tre_application_save.ServerCompanyCodeID = '1-1'      
      portal_tre_application_save.save

      redirect_to edit_portal_tre_application_path(id: portal_tre_application_save.id)
  end

  def post_tre
    portal_tre_application_rec_checker = PortalTreApplication.where(ID: params[:tre_id]).pluck(:IsActive).to_sentence

    if portal_tre_application_rec_checker == 'false'
      flash[:notice] = "No details."
      redirect_to edit_portal_tre_application_path(id: params[:tre_id])

    else      
      #portal_tre_application_rec = PortalTreApplication.where(ID: params[:tre_id])

      #portal_tre_application_rec.each do |portal_tre_application_rec1|
      #  portal_tre_application_rec1.FilingStatusRefNo = 40
      #  portal_tre_application_rec1.save
      #end

      #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSPost @Type = 'tre', @ID = #{params[:tre_id]}")
      ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 5, @ID = #{params[:tre_id]}, @UserRefNo = -1, @Status = 40, @Remarks = ''")
      
      flash[:notice] = "Record has been requested."
      redirect_to portal_tre_applications_path
    end
  end

  private
    def set_portal_tre_application
      @portal_tre_application = PortalTreApplication.find(params[:id])
    end

    def portal_tre_application_params
      params.fetch(:portal_tre_application, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :FilingStatusRefNo, :Amount, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate)
    end
end