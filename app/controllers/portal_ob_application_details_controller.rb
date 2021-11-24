class PortalObApplicationDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_ob_application_detail, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url 
    @portal_ob_application_details = PortalObApplicationDetail.where(OBApplicationRefNo: session[:portal_ob_application_id], IsImported: 0, IsCanceled: 0)

    render :layout => false
  end

  def show
    render :layout => false
  end

  def new
    @portal_ob_application_detail = PortalObApplicationDetail.new
    render :layout => false
  end

  def edit
    render :layout => false
  end

  def create
    @portal_ob_application_detail = PortalObApplicationDetail.new(portal_ob_application_detail_params)

    if @portal_ob_application_detail.WorkDate != @portal_ob_application_detail.EndDate && @portal_ob_application_detail.EndDate.blank? == false && @portal_ob_application_detail.WorkDate.blank? == false
      errmsg = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_InsertOB #{@portal_ob_application_detail.OBApplicationRefNo}, #{@portal_ob_application_detail.CreatedBy}, '#{@portal_ob_application_detail.WorkDate.to_date}', '#{@portal_ob_application_detail.EndDate.to_date}', #{@portal_leave_application_detail.ClientAccountRefNo}, '#{@portal_ob_application_detail.StartTime.to_date}', '#{@portal_ob_application_detail.EndTime.to_date}', '#{@portal_leave_application_detail.Task}'")

      respond_to do |format|        
        if errmsg.rows[0][0] != ''
          format.html { render :new, :layout => false }
          @warning = errmsg.rows[0][0]
        else
          @portal_ob_application_detail.save
          
          format.html { redirect_to portal_ob_application_details_path, notice: 'OB detail was successfully created.' }
          format.json { render :show, status: :created, location: @portal_ob_application_detail }        
        end
      end
    
    else 
      respond_to do |format|
        if @portal_ob_application_detail.save
          format.html { redirect_to portal_ob_application_details_path, notice: 'OB detail was successfully created.' }
          format.json { render :show, status: :created, location: @portal_ob_application_detail }
        else
          format.html { render :new, :layout => false }
          format.json { render json: @portal_ob_application_detail.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_ob_application_detail.update(portal_ob_application_detail_params) 
        format.html { redirect_to portal_ob_application_details_path, notice: 'OB detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_ob_application_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_ob_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_portal_ob_application_detail
      @portal_ob_application_detail = PortalObApplicationDetail.find(params[:id])
    end

    def portal_ob_application_detail_params
      params.fetch(:portal_ob_application_detail, {}).permit(:ID, :OBApplicationRefNo, :ClientAccountRefNo, :WorkDate, :StartTime, :EndTime, :Task, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :ServerCompanyCodeID)
    end
end