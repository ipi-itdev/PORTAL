class PortalLeaveApplicationDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_leave_application_detail, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url     
    @portal_leave_application_details = PortalLeaveApplicationDetail.where(LeaveApplicationRefNo: session[:portal_leave_application_id], IsImported: 0, IsCanceled: 0).or(PortalLeaveApplicationDetail.where(LeaveApplicationRefNo: session[:portal_leave_approval_id], IsImported: 0, IsCanceled: 0))
    @employee_group = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck(:EmployeeGroupRefNo).to_sentence

    render :layout => false
  end

  def show
    render :layout => false
  end

  def new    
    @portal_leave_application_detail = PortalLeaveApplicationDetail.new
    render :layout => false
  end

  def edit      
    render :layout => false
  end

  def create
    @portal_leave_application_detail = PortalLeaveApplicationDetail.new(portal_leave_application_detail_params)

    if @portal_leave_application_detail.WorkDate != @portal_leave_application_detail.EndDate && @portal_leave_application_detail.EndDate.blank? == false && @portal_leave_application_detail.WorkDate.blank? == false
      errmsg = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_InsertLeaves #{@portal_leave_application_detail.LeaveApplicationRefNo}, #{@portal_leave_application_detail.CreatedBy}, '#{@portal_leave_application_detail.WorkDate.to_date}', '#{@portal_leave_application_detail.EndDate.to_date}', #{@portal_leave_application_detail.LeaveTypeRefNo}, #{@portal_leave_application_detail.LeaveCreditTypeRefNo}, '#{@portal_leave_application_detail.Reason}', '#{@portal_leave_application_detail.AsSL}'")

      respond_to do |format|        
        if errmsg.rows[0][0] != ''
          format.html { render :new, :layout => false }
          @warning = errmsg.rows[0][0]
        else
          @portal_leave_application_detail.save
          
          format.html { redirect_to portal_leave_application_details_path, notice: 'Leave detail was successfully created.' }
          format.json { render :show, status: :created, location: @portal_leave_application_detail }        
        end
      end

    else      
      respond_to do |format|
        if @portal_leave_application_detail.save
          format.html { redirect_to portal_leave_application_details_path, notice: 'Leave detail was successfully created.' }
          format.json { render :show, status: :created, location: @portal_leave_application_detail }
        else
          format.html { render :new, :layout => false }
          format.json { render json: @portal_leave_application_detail.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_leave_application_detail.update(portal_leave_application_detail_params)        
        format.html { redirect_to portal_leave_application_details_path, notice: 'Leave detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_leave_application_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_leave_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_portal_leave_application_detail
      @portal_leave_application_detail = PortalLeaveApplicationDetail.find(params[:id])
    end

    def portal_leave_application_detail_params
      params.fetch(:portal_leave_application_detail, {}).permit(:ID, :LeaveApplicationRefNo, :LeaveTypeRefNo, :LeaveCreditTypeRefNo, :WorkDate, :Reason, :AttachmentFile, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :ServerCompanyCodeID, :EndDate, :AsSL)
    end
end