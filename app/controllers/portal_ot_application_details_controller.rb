class PortalOtApplicationDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_ot_application_detail, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url 
    @portal_ot_application_details = PortalOtApplicationDetail.where(OvertimeApplicationRefNo: session[:portal_ot_application_id], IsImported: 0, IsCanceled: 0).or(@portal_ot_application_details = PortalOtApplicationDetail.where(OvertimeApplicationRefNo: session[:portal_ot_approval_id], IsImported: 0, IsCanceled: 0))

    render :layout => false
  end

  def show
    render :layout => false
  end

  def new
    @portal_ot_application_detail = PortalOtApplicationDetail.new
    
    render :layout => false
  end

  def edit
    render :layout => false
  end

  def create
    @portal_ot_application_detail = PortalOtApplicationDetail.new(portal_ot_application_detail_params)

    respond_to do |format|
      if @portal_ot_application_detail.save
        format.html { redirect_to portal_ot_application_details_path, notice: 'Overtime detail was successfully created.' }
        #ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_InsertOTTask #{@portal_ot_application_detail.ID}")
        format.json { render :show, status: :created, location: @portal_ot_application_detail }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @portal_ot_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_ot_application_detail.update(portal_ot_application_detail_params)        
        format.html { redirect_to portal_ot_application_details_path, notice: 'Overtime detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_ot_application_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_ot_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_portal_ot_application_detail
      @portal_ot_application_detail = PortalOtApplicationDetail.find(params[:id])
    end

    def portal_ot_application_detail_params
      params.fetch(:portal_ot_application_detail, {}).permit(:ID, :OvertimeApplicationRefNo, :WorkDate, :StartTime, :EndTime, :Task, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :ServerCompanyCodeID, :AttachmentFile)
    end
end