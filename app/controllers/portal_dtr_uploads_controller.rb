class PortalDtrUploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_dtr_upload, only: [:edit, :update, :destroy]

  def index
    @portal_dtr_uploads = PortalDtrUpload.find_by_sql("select * from PORTAL_DtrUpload_U where IsActive = 1 AND EmployeeRefNo = #{current_user.EmployeeRefNo}")
  end

  def new
    @portal_dtr_upload = PortalDtrUpload.new
  end

  def edit
    @get_edit_id = PortalDtrUpload.find(params[:id])
    session[:portal_dtrupload_isadd] = 1
  end

  def create
    @portal_dtr_upload= PortalDtrUpload.new(portal_dtr_upload_params)

    respond_to do |format|
      if @portal_dtr_uploads.save
        format.html { redirect_to @portal_dtr_upload}
        format.json { render :show, status: :created, location: @portal_dtr_upload}
      else
        format.html { render :new }
        format.json { render json: @portal_dtr_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_dtr_upload.update(portal_dtr_upload_params)
        format.html { redirect_to '/portal_dtr_uploads', notice: 'Upload DTR was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_dtr_upload }
      else
        format.html { render :edit }
        format.json { render json: @portal_dtr_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    get_tre_details_rec = PortalDtrUploadDetail.where(DtrUploadRefNo: @portal_dtr_upload.id)
    get_tre_details_rec.destroy_all
  
    get_tre_rec = PortalDtrUpload.where(DtrUploadRefNo: @portal_dtr_upload.id)
    get_tre_rec.destroy_all

    flash[:notice] = "Record has been deleted."
    redirect_to portal_dtr_uploads_path
  end

  def create_dtr
    @getActiveUpload = PortalDtrUpload.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck(:ID).to_sentence
    if @getActiveUpload == "" 

      errmsg = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_DTRUploadValidation #{current_user.EmployeeRefNo}")
      
      if errmsg.rows[0][0] == ''
        portal_dtr_upload_save  = PortalDtrUpload.new
        portal_dtr_upload_save.EmployeeRefNo = current_user.EmployeeRefNo
        portal_dtr_upload_save.CreatedBy = current_user.EmployeeRefNo
        portal_dtr_upload_save.ModifiedBy = current_user.EmployeeRefNo
        portal_dtr_upload_save.ServerCompanyCodeID = '1-1'      
        portal_dtr_upload_save.save

        redirect_to edit_portal_dtr_upload_path(id: portal_dtr_upload_save.id)
      else
        flash[:notice] = errmsg.rows[0][0]
        redirect_to portal_dtr_uploads_path
      end
    else
      flash[:notice] = "Existing DTR Upload."
      redirect_to portal_dtr_uploads_path
    end
  end

  private
    def set_portal_dtr_upload
      @portal_dtr_upload = PortalDtrUpload.find(params[:id])
    end

    def portal_dtr_upload_params
      params.fetch(:portal_dtr_upload, {}).permit(:ID, :EmployeeRefNo, :PayrollDate, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate)
    end
end