class PortalTreApplicationDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_tre_application_detail, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url     
    @portal_tre_application_details = PortalTreApplicationDetail.where(TreApplicationRefNo: session[:portal_tre_application_id])    

    render :layout => false
  end

  def show
    render :layout => false
  end

  def new    
    @portal_tre_application_detail = PortalTreApplicationDetail.new
    render :layout => false
  end

  def edit      
    render :layout => false
  end

  def make_hash
    res = []
    columns_to_skip = ["CreatedDate", "ModifiedDate", "hash"]
    for column in PortalTreApplicationDetail.content_columns
      next if columns_to_skip.include?(column.name) or
              self[column.name].nil? or
              self[column.name].blank?
      res << self[column.name]
    end
  
    res.hash.to_s
  end

  def create
    @portal_tre_application_detail = PortalTreApplicationDetail.new(portal_tre_application_detail_params)
       
    respond_to do |format|
      if @portal_tre_application_detail.save

        format.html { redirect_to portal_tre_application_details_path, notice: 'Tre detail was successfully created.' }
        format.json { render :show, status: :created, location: @portal_tre_application_detail }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @portal_tre_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_tre_application_detail.update(portal_tre_application_detail_params)
        
        format.html { redirect_to portal_tre_application_details_path, notice: 'Tre detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_tre_application_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_tre_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_tre_application_detail
      @portal_tre_application_detail = PortalTreApplicationDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_tre_application_detail_params
      params.fetch(:portal_tre_application_detail, {}).permit(:ID, :TREApplicationRefNo, :EntryRefNo, :ClientAccountRefNo, :WorkDate, :Amount, :AttachmentFile, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :ServerCompanyCodeID)
    end
end