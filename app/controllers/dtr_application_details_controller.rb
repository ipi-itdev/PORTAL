class DtrApplicationDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dtr_application_detail, only: [:show, :edit, :update]

  def index
    #session[:set_base_dtr_approval_id] = ''
    #session[:set_base_emprefno] = ''
    @hash_url = request.params
    #@get_url_valuex = request.original_url
    #session[:set_base_dtr_approval_id] = @hash_url[:dtr_app_id]
    #session[:set_base_emprefno] = @hash_url[:employeerefno]  

    @dtr_application_details = DtrApplicationDetail.where(DtrApplicationRefNo: @hash_url[:dtr_app_id], EmployeeRefNo: @hash_url[:employeerefno])

    render :layout => false
  end

  def show
    render :layout => false
  end

  def new    
    @dtr_application_detail = DtrApplicationDetail.new
    render :layout => false
  end

  def edit
    @hash_url_edit = request.params
    @base_id_test = 0
    @dtr_application_detail = DtrApplicationDetail.find(params[:id]) 
    render :layout => false
  end

  def create
    @dtr_application_detail = DtrApplicationDetail.new(dtr_application_detail_params)
         
    respond_to do |format|
      if @dtr_application_detail.save
        format.html { redirect_to dtr_application_details_path, notice: 'Weekly schedule detail was successfully created.' }
        format.json { render :show, status: :created, location: @dtr_application_detail }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @dtr_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @dtr_application_detail.update(dtr_application_detail_params)

        get_dtr_application_details = dtr_application_detail_params

        format.html { redirect_to "/dtr_application_details?dtr_app_id=#{params[:base_id]}&employeerefno=#{params[:emprefno]} ", notice: "DTR detail was successfully updated.." }              
        #format.html { redirect_to dtr_application_details_path, notice: 'DTR detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @dtr_application_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @dtr_application_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_dtr_application_detail
      @dtr_application_detail = DtrApplicationDetail.find(params[:id])
    end

    def dtr_application_detail_params
      params.fetch(:dtr_application_detail, {}).permit(:ID, :DtrApplicationRefNo, :EmployeeRefNo, :WorkDate, :TimeIn, :TimeOut, :DayStatus, :Remarks, :base_id_test, :test_id)
      #params.require(:dtr_application_detail).permit(:ID, :DtrApplicationRefNo, :EmployeeRefNo, :WorkDate, :TimeIn, :TimeOut, :DayStatus, :Remarks, :base_id_test, :test_id)

    end
end




