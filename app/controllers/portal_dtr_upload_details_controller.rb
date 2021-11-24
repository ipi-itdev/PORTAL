class PortalDtrUploadDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_dtr_upload_detail, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url     
    @portal_dtr_upload_details = PortalDtrUploadDetail.where(DtrUploadRefNo: session[:portal_dtr_upload_id])    

    render :layout => false
  end

  def show
    render :layout => false
  end

  def new    
    @portal_dtr_upload_detail = PortalDtrUploadDetail.new
    render :layout => false
  end

  def edit      
    render :layout => false
  end

  def make_hash
    res = []
    columns_to_skip = ["CreatedDate", "ModifiedDate", "hash"]
    for column in PortalDtrUploadDetail.content_columns
      next if columns_to_skip.include?(column.name) or
              self[column.name].nil? or
              self[column.name].blank?
      res << self[column.name]
    end
  
    res.hash.to_s
  end

  def create
    @portal_dtr_upload_detail = PortalDtrUploadDetail.new(portal_dtr_upload_detail_params)
       
    respond_to do |format|
      if @portal_dtr_upload_detail.save

        format.html { redirect_to portal_dtr_upload_details_path, notice: 'DTR Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @portal_dtr_upload_detail }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @portal_dtr_upload_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_dtr_upload_detail.update(portal_dtr_upload_detail_params)
        
        format.html { redirect_to portal_dtr_upload_details_path, notice: 'DTR Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_dtr_upload_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_dtr_upload_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_dtr_upload_detail
      @portal_dtr_upload_detail = PortalDtrUploadDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_dtr_upload_detail_params
      params.fetch(:portal_dtr_upload_detail, {}).permit(:ID, :DTRUploadRefNo, :Description, :AttachmentFile, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :ServerCompanyCodeID)
    end
end