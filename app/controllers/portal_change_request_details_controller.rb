class PortalChangeRequestDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_change_request_detail, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url     
    @portal_change_request_details = PortalChangeRequestDetail.where(EmployeeProfileChangeRequestRefNo: session[:portal_change_request_id])
    
    render :layout => false
  end

  def show
    render :layout => false
  end

  def new    
    @portal_change_request_detail = PortalChangeRequestDetail.new
    render :layout => false
  end

  def edit      
    render :layout => false
  end

  def create
    @portal_change_request_detail = PortalChangeRequestDetail.new(portal_change_request_detail_params)
         
    respond_to do |format|
      if @portal_change_request_detail.save
        format.html { redirect_to portal_change_request_details_path, notice: 'Change request detail was successfully created.' }
        format.json { render :show, status: :created, location: @portal_change_request_detail }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @portal_change_request_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_change_request_detail.update(portal_change_request_detail_params)        
        format.html { redirect_to portal_change_request_details_path, notice: 'Change request detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_change_request_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_change_request_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_portal_change_request_detail
      @portal_change_request_detail = PortalChangeRequestDetail.find(params[:id])
    end

    def portal_change_request_detail_params
      params.fetch(:portal_change_request_detail, {}).permit(:ID, :EmployeeProfileChangeRequestRefNo, :ChangeRequestTypeRefNo, :IsCheked, :StatutoryTypeRefNo, :RequirementRefNo, :AttachmentFile, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :ServerCompanyCodeID,
      :CurrentAddress, :PermanentAddress, :TelephoneNumber, :MobileNumber, :PersonalEmailAddress, :EmergencyName, :EmergencyAddress, :EmergencyContactNumber, :EmergencyRelationship, :SSS, :Pagibig, :Philhealth, :DepName, :DepBirthDate, :DepRelationship, :School, :Course, :YearGraduated)
    end
end