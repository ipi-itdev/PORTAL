class PortalBirUploadDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_bir_upload_detail, only: %i[ show edit update destroy ]

  # GET /portal_bir_upload_details or /portal_bir_upload_details.json
  def index
    @portal_bir_upload_details = PortalBirUploadDetail.all
  end

  # GET /portal_bir_upload_details/1 or /portal_bir_upload_details/1.json
  def show
  end

  # GET /portal_bir_upload_details/new
  def new
    if PortalBirUploadDetail.where(EmployeeRefNo:current_user.EmployeeRefNo ).exists? == false
          @portal_bir_upload_detail = PortalBirUploadDetail.new
    else
      flash[:notice] = 'Record Already Exists!'
      redirect_to pages_path
    end  

  end

  # GET /portal_bir_upload_details/1/edit
  #def edit
  #end

  # POST /portal_bir_upload_details or /portal_bir_upload_details.json
  def create
    @portal_bir_upload_detail = PortalBirUploadDetail.new(portal_bir_upload_detail_params)

    respond_to do |format|
      if @portal_bir_upload_detail.save
        
        get_bir_rec = PortalBirAccessLog.where(EmployeeRefNo: current_user.EmployeeRefNo)
        get_bir_rec.update(FormReturned: true)
  
        portal_login  = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, IPAddress: request.remote_ip, Module: request.url  )
        portal_login.save

        format.html { redirect_to '/portal_bir_upload_confirmed', notice: "Saved" }
        format.json { render :show, status: :created, location: @portal_bir_upload_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @portal_bir_upload_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_bir_upload_details/1 or /portal_bir_upload_details/1.json
  def update
    respond_to do |format|
      if @portal_bir_upload_detail.update(portal_bir_upload_detail_params)
        format.html { redirect_to portal_bir_upload_detail_url(@portal_bir_upload_detail), notice: "Portal bir upload detail was successfully updated." }
        format.json { render :show, status: :ok, location: @portal_bir_upload_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @portal_bir_upload_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  ## DELETE /portal_bir_upload_details/1 or /portal_bir_upload_details/1.json
  #def destroy
  #  @portal_bir_upload_detail.destroy

  #  respond_to do |format|
  #    format.html { redirect_to portal_bir_upload_details_url, notice: "Portal bir upload detail was successfully destroyed." }
  #    format.json { head :no_content }
  #  end
  #end

  def portal_bir_download_form
    #check if emp has existing  rec
    if PortalBirAccessLog.where(EmployeeRefNo:current_user).exists? == false

    ##bir2316
    get_companycode = GenCompanyM.where(IsActive: 1).pluck(:Code).to_sentence
    @BIRpath = "/BIRFORMS/#{get_companycode}/"
    @getBIRCredentials = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_BIR2316Credentials @EmpRefNo= #{current_user.EmployeeRefNo}")     
    @BIRlink = "#{@BIRpath}#{@getBIRCredentials.rows[0][0]}"
    ##bir2316

    portal_login  = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, IPAddress: request.remote_ip, Module: request.url  )
    portal_login.save

    else
      redirect_to pages_path
    end

  end

  def portal_bir_download_form_process
    get_utc = ActiveRecord::Base.connection.exec_query("SELECT DATEADD(HOUR,8,GETUTCDATE())")
    current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')
    bir_access_log = PortalBirAccessLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, TimeLog: current_datetime, IsActive: true, FormReturned: true )
    bir_access_log.save

    portal_login  = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, IPAddress: request.remote_ip, Module: request.url  )
    portal_login.save

    session[:bir_upload_flag] = false # true = prompt / false = no prompt

    redirect_to portal_bir_download_confirmed_path

  end

  def portal_bir_download_confirmed
     #confirmed download page

    portal_login  = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, IPAddress: request.remote_ip, Module: request.url  )
    portal_login.save
  end


  def portal_bir_uploaded_list
    if current_user.IsAdmin == true
      @portal_bir_upload_details = PortalBirUploadDetail.all
    else
      @portal_bir_upload_details = PortalBirUploadDetail.where(EmployeeRefNo:current_user.EmployeeRefNo)
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_bir_upload_detail
      @portal_bir_upload_detail = PortalBirUploadDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portal_bir_upload_detail_params
      params.require(:portal_bir_upload_detail).permit(:BIRUploadDetailRefNo, :BIRUploadRefNo, :EmployeeRefNo, :Description, :AttachmentFile, :CreatedDate, :CreatedBy, :ModifiedDate, :ModifiedBy, :IsActive)
    end
end
