class PortalBirUploadsController < ApplicationController
  before_action :set_portal_bir_upload, only: %i[ show edit update destroy ]

  # GET /portal_bir_uploads or /portal_bir_uploads.json
  def index
    @portal_bir_uploads = PortalBirUpload.all
  end

  # GET /portal_bir_uploads/1 or /portal_bir_uploads/1.json
  def show
  end

  # GET /portal_bir_uploads/new
  def new
    @portal_bir_upload = PortalBirUpload.new
  end

  # GET /portal_bir_uploads/1/edit
  def edit
  end

  # POST /portal_bir_uploads or /portal_bir_uploads.json
  def create
    @portal_bir_upload = PortalBirUpload.new(portal_bir_upload_params)

    respond_to do |format|
      if @portal_bir_upload.save
        format.html { redirect_to portal_bir_upload_url(@portal_bir_upload), notice: "Portal bir upload was successfully created." }
        format.json { render :show, status: :created, location: @portal_bir_upload }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @portal_bir_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_bir_uploads/1 or /portal_bir_uploads/1.json
  def update
    respond_to do |format|
      if @portal_bir_upload.update(portal_bir_upload_params)
        format.html { redirect_to portal_bir_upload_url(@portal_bir_upload), notice: "Portal bir upload was successfully updated." }
        format.json { render :show, status: :ok, location: @portal_bir_upload }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @portal_bir_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_bir_uploads/1 or /portal_bir_uploads/1.json
  def destroy
    @portal_bir_upload.destroy

    respond_to do |format|
      format.html { redirect_to portal_bir_uploads_url, notice: "Portal bir upload was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_bir_upload
      @portal_bir_upload = PortalBirUpload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portal_bir_upload_params
      params.require(:portal_bir_upload).permit(:BIRUploadRefNo, :Year, :CreatedDate, :CreatedBy, :ModifiedDate, :ModifiedBy, :IsActive)
    end
end
