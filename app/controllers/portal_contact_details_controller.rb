class PortalContactDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_contact_detail, only: [:show, :edit, :update]

  def index
      @get_url_valuex = request.original_url     
      @portal_contact_details = PortalContactDetail.where(ContactRefNo: session[:portal_contact_id])

      render :layout => false
  end

  def show
    render :layout => false
  end

  def edit      
    render :layout => false
  end

  def update   
    respond_to do |format|         
      if @portal_contact_detail.update(portal_contact_detail_params)       
        ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_UpdateInformation #{current_user.EmployeeRefNo}")
        format.html {render :template => "portal_contact_details/thanks_contact_details", :layout => false}
      else         
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_contact_detail.errors, status: :unprocessable_entity }
      end
    end
  end


  def thanks_contact_details
    
  end

  private
    def set_portal_contact_detail
      @portal_contact_detail = PortalContactDetail.find(params[:id])
    end

    def portal_contact_detail_params
      params.fetch(:portal_contact_detail, {}).permit(:ID, :ContactRefNo, :IsActive, :CivilStatusRefNo,
        :PermanentRegionRefNo, :PermanentProvinceRefNo, :PermanentMunicipalityRefNo, :PermanentBrgyRefNo, :PermanentAddress,
        :PresentRegionRefNo, :PresentProvinceRefNo, :PresentMunicipalityRefNo, :PresentBrgyRefNo, :PresentAddress,      
        :EmergencyName1, :EmergencyAddress1, :EmergencyContactNo1, :EmergencyEmail1, :EmergencySecondaryContact1, :EmergencyRelationship1,
        :EmergencyName2, :EmergencyAddress2, :EmergencyContactNo2, :EmergencyEmail2, :EmergencySecondaryContact2, :EmergencyRelationship2,                            
        :PersonalEmailAddress, :WorkEmailAddress, :TelephoneNumber, :MobileNumber, :MobileNumber2, :IsSame)
    end
end

