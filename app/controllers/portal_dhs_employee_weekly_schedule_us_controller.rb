class PortalDhsEmployeeWeeklyScheduleUsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_dhs_employee_weekly_schedule_u, only: [:show, :edit, :update, :destroy]
  prepend_before_action :log_login
  prepend_before_action :check_current_user

  # GET /portal_dhs_employee_weekly_schedule_us
  # GET /portal_dhs_employee_weekly_schedule_us.json
  def index
    if PortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: current_user.EmployeeRefNo, BackToEmployee: 1).count == 0
      @weeksched = PortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsNew: 1, IsActive: 1)
      @foredit = 0
    else
      @weeksched = PortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: current_user.EmployeeRefNo, BackToEmployee: 1)
      @foredit = 1
    end
    
    @get_fixed_sched_test = User.where(EmployeeRefNo: current_user.EmployeeRefNo)

    @get_fixed_sched = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:fixed_sched)
    get_id = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:ID)
    @get_fixed_sched1 = User.new
  end

  def weekschedhist
    @testssss = current_user.EmployeeRefNo
    
    #@get_existing_sched = PortalDhsEmployeeWeeklyScheduleU.where(WorkDate: (params[:WorkDateFrom])..params[:WorkDateTo], EmployeeRefNo: current_user.EmployeeRefNo ).order(:WorkDate)
    @get_existing_sched = DtrWeeklysched.where(WorkDate: (params[:WorkDateFrom])..params[:WorkDateTo], EmployeeRefNo: current_user.EmployeeRefNo ).order(:WorkDate)


      #set workdate
      @get_count_existing_sched = @get_existing_sched.count

      if @get_count_existing_sched <= 0
        #nothing to do
      else    
        session[:WorkDateFrom_session] = params[:WorkDateFrom]
        session[:WorkDateTo_session] = params[:WorkDateTo]

        #@get_worksched_pdf_path = "/portal_dhs_employee_weekly_schedule_us/#{@get_existing_sched.ids.first}.pdf"        
      end
  end

  # GET /portal_dhs_employee_weekly_schedule_us/1
  # GET /portal_dhs_employee_weekly_schedule_us/1.json
  def show
    respond_to do |format|
          format.html
          format.pdf do

            render pdf: 'DTR_Report',
                   template: "portal_dhs_employee_weekly_schedule_us/dtrhistorydetails.html.erb",
                   formats: [:html],
                   disposition: :inline,
                   orientation:'Landscape',
                   footer: { right: "[page] of [topage] - #{DateTime.now.strftime("%m/%d/%Y %H:%M")}" }
          end
        end
  end

  # GET /portal_dhs_employee_weekly_schedule_us/new
  def new
    @portal_dhs_employee_weekly_schedule_u = PortalDhsEmployeeWeeklyScheduleU.new
  end

  # GET /portal_dhs_employee_weekly_schedule_us/1/edit
  def edit    
  end

  # POST /portal_dhs_employee_weekly_schedule_us
  # POST /portal_dhs_employee_weekly_schedule_us.json
  def create
    @portal_dhs_employee_weekly_schedule_u = PortalDhsEmployeeWeeklyScheduleU.new(portal_dhs_employee_weekly_schedule_u_params)

    respond_to do |format|
      if @portal_dhs_employee_weekly_schedule_u.save
        format.html { redirect_to @portal_dhs_employee_weekly_schedule_u, notice: 'Portal dhs employee weekly schedule u was successfully created.' }
        format.json { render :show, status: :created, location: @portal_dhs_employee_weekly_schedule_u }
      else
        format.html { render :new }
        format.json { render json: @portal_dhs_employee_weekly_schedule_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_dhs_employee_weekly_schedule_us/1
  # PATCH/PUT /portal_dhs_employee_weekly_schedule_us/1.json
  def update
    hash_check_shifts = PortalDhsEmployeeWeeklyScheduleU.where(ID: params[:id]).pluck_to_hash(:IsRD, :shift_start, :shift_end)
    @check_shifts = hash_check_shifts[0] 

    ###
    respond_to do |format|
      if @portal_dhs_employee_weekly_schedule_u.update(portal_dhs_employee_weekly_schedule_u_params)

        get_updated = PortalDhsEmployeeWeeklyScheduleU.where(ID: params[:id])

        get_updated.each do |get_updated|
          if get_updated.IsRD == true 
            sched = PortalDhsEmployeeWeeklyScheduleU.find_by(ID: params[:id])
            sched.WorkSched = ''
            sched.shift_start = ''
            sched.shift_end = ''
            sched.save 
          end
        end

        format.html { redirect_to portal_dhs_employee_weekly_schedule_us_url, notice: 'Schedule Saved' }
        format.json { render :show, status: :ok, location: @portal_dhs_employee_weekly_schedule_u }
        #format.js
      else
        format.html { render :edit}
        format.json { render json: @portal_dhs_employee_weekly_schedule_u.errors, status: :unprocessable_entity }
      end
    end
    ###      
  end

  # DELETE /portal_dhs_employee_weekly_schedule_us/1
  # DELETE /portal_dhs_employee_weekly_schedule_us/1.json
  def destroy
    @portal_dhs_employee_weekly_schedule_u.destroy
    respond_to do |format|
      format.html { redirect_to portal_dhs_employee_weekly_schedule_us_url, notice: 'Portal dhs employee weekly schedule u was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def timein
    #update_rec = PortalDhsEmployeeWeeklyScheduleU.find_by(ID: params[:id_rec])
    ActiveRecord::Base.connection.execute("exec dbo.spTimeinLogs @EmployeeRefNo = #{params[:emprefno_rec]}, @ID = #{params[:id_rec]}")
    flash[:notice] = 'Time-in Saved'
    redirect_to '/portal_dhs_employee_weekly_schedule_us'
  end

  def timeout
    if user_signed_in? == true
      if params[:task_tag].blank? == true
        flash[:notice] = "Tasked Performed are required."
        redirect_to '/emptimeout'

      else
        ActiveRecord::Base.connection.execute("exec dbo.spTimeoutLogs @EmployeeRefNo = #{params[:emprefno_rec]}, @ID = #{params[:id_rec]}, @Remarks = '#{params[:task_tag].gsub("'","`")}', @WorkLocationRefNo = #{params[:WorkLocationRefNo].to_s}")
        flash[:notice] = 'Time-out Saved'
        redirect_to '/portal_dhs_employee_weekly_schedule_us'
      end

    else
      flash[:notice] = 'Session ended, Please try to login.'
      redirect_to '/'
    end
  end

  def fixed_sched
    get_user_rec = User.where(EmployeeRefNo:params[:employeerefno])
    get_user_rec.update(fixed_sched: params[:fixed_sched])

    flash[:notice] = 'Record Saved'
    redirect_to portal_dhs_employee_weekly_schedule_us_url
  end

  def schedule_confirmation
    @weeksched_confirm = PortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsNew: 1, IsActive: 1)
    @get_fixed_sched = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:fixed_sched)
    get_id = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:ID)
    @get_fixed_sched1 = User.new
  end

  def confirm_sched
    get_user_sched_update = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
    get_user_sched_update.update(sched_confirmed: 1)

    redirect_to pages_path
  end

  def set_fixed_sched
    if params[:shift_start_tag].blank? == true || params[:shift_end_tag].blank? == true
      flash[:notice] = "Shift Start/End is blank"
      redirect_to '/fixedschedulepage'

    else          
      get_rec_to_be_fixedsched = PortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsNew: 1, IsActive: 1, IsRD: 0, time_in: nil, time_out: nil)

      get_the_hrs =  params[:shift_start_tag].to_time
      get_the_hrs1 = get_the_hrs.strftime('%H')

      get_the_mins =  params[:shift_start_tag].to_time
      get_the_mins1 = get_the_mins.strftime('%M')

      get_the_sec =  params[:shift_start_tag].to_time
      get_the_sec1 = get_the_sec.strftime('%M')

      get_the_hrs_end =  params[:shift_end_tag].to_time
      get_the_hrs1_end = get_the_hrs_end.strftime('%H')

      get_the_mins_end =  params[:shift_end_tag].to_time
      get_the_mins1_end  = get_the_mins_end.strftime('%M')

      get_the_sec_end =  params[:shift_end_tag].to_time
      get_the_sec1_end  = get_the_sec_end.strftime('%M')

      #ActiveRecord::Base.connection.execute("exec PORTAL_SP_update_leaveapp_refno @RefNo = #{portal_leave_application_auto.id}")

      get_rec_to_be_fixedsched.each do |get_rec_to_be_fixedsched|
        get_rec_to_be_fixedsched.shift_start = get_rec_to_be_fixedsched.WorkDate.to_time.strftime('%Y-%m-%d %H:%M:%S')
        get_rec_to_be_fixedsched.shift_end = get_rec_to_be_fixedsched.WorkDate.to_time.strftime('%Y-%m-%d %H:%M:%S')

        if params[:shift_end_tag] < params[:shift_start_tag]
          get_rec_to_be_fixedsched.shift_end = get_rec_to_be_fixedsched.shift_end + 1.day
        end

        get_rec_to_be_fixedsched.shift_start  = get_rec_to_be_fixedsched.shift_start.change(hour: get_the_hrs1.to_i, min: get_the_mins1.to_i ) 
        get_rec_to_be_fixedsched.shift_end = get_rec_to_be_fixedsched.shift_end.change(hour: get_the_hrs1_end.to_i, min: get_the_mins1_end.to_i)

        get_rec_to_be_fixedsched.save
      end

      get_user_rec = User.where(EmployeeRefNo:current_user.EmployeeRefNo)
      get_user_rec.update(fixed_sched: 1)
      
      flash[:notice] = "Default Schedule Saved"

      redirect_to portal_dhs_employee_weekly_schedule_us_url
    end
  end

  def emptimeout
    if user_signed_in? == true
      @datetime_range = ActiveRecord::Base.connection.exec_query("SELECT * FROM fnSchedEmployee(#{current_user.EmployeeRefNo})")

    else
      flash[:notice] = 'Session ended, Please try to login.'
      redirect_to '/'
    end
  end

  def fixedschedulepage    
  end

  def fixed_sched_set
    if params[:shift_start_tag].blank? == true || params[:shift_end_tag].blank? == true
      flash[:notice] = "Shift Start/End is blank"
      redirect_to '/fixed_sched_set'

    else
      get_rec_to_be_fixedsched = PortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsNew: 1, IsActive: 1, IsRD: 0, time_in: nil, time_out: nil)

      get_the_hrs =  params[:shift_start_tag].to_time
      get_the_hrs1 = get_the_hrs.strftime('%H')

      get_the_mins =  params[:shift_start_tag].to_time
      get_the_mins1 = get_the_mins.strftime('%M')

      get_the_sec =  params[:shift_start_tag].to_time
      get_the_sec1 = get_the_sec.strftime('%M')


      get_the_hrs_end =  params[:shift_end_tag].to_time
      get_the_hrs1_end = get_the_hrs_end.strftime('%H')

      get_the_mins_end =  params[:shift_end_tag].to_time
      get_the_mins1_end  = get_the_mins_end.strftime('%M')

      get_the_sec_end =  params[:shift_end_tag].to_time
      get_the_sec1_end  = get_the_sec_end.strftime('%M')

      #ActiveRecord::Base.connection.execute("exec PORTAL_SP_update_leaveapp_refno @RefNo = #{portal_leave_application_auto.id}")

      get_rec_to_be_fixedsched.each do |get_rec_to_be_fixedsched|

        get_rec_to_be_fixedsched.shift_start = get_rec_to_be_fixedsched.WorkDate.to_time.strftime('%Y-%m-%d %H:%M:%S')
        get_rec_to_be_fixedsched.shift_end = get_rec_to_be_fixedsched.WorkDate.to_time.strftime('%Y-%m-%d %H:%M:%S')
        
        if params[:shift_end_tag] < params[:shift_start_tag]
          get_rec_to_be_fixedsched.shift_end = get_rec_to_be_fixedsched.shift_end + 1.day
        end

        get_rec_to_be_fixedsched.shift_start  = get_rec_to_be_fixedsched.shift_start.change(hour: get_the_hrs1.to_i, min: get_the_mins1.to_i ) 
        get_rec_to_be_fixedsched.shift_end = get_rec_to_be_fixedsched.shift_end.change(hour: get_the_hrs1_end.to_i, min: get_the_mins1_end.to_i)

        get_rec_to_be_fixedsched.save
      end

      get_user_rec = User.where(EmployeeRefNo:current_user.EmployeeRefNo)
      get_user_rec.update(fixed_sched: 1, sched_confirmed: 1)
    
      flash[:notice] = "Fixed Schedule Saved"

      redirect_to pages_path
    end
  end

  def request_dtr    
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 1, @ID =  0, @UserRefNo = '#{current_user.EmployeeRefNo}', @Status = 40, @Remarks = ''")
    
    flash[:notice] = "DTR requested."
    redirect_to pages_path
  end


  def log_login
    portal_login  = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, IPAddress: request.remote_ip, Module: request.url  )
    portal_login.save    
  end


  def dtrhistorydetails
    render :layout => false

    @emprefno = current_user.EmployeeRefNo
    @set_workdate_from = session[:WorkDateFrom_session]   
    @set_workdate_to = session[:WorkDateTo_session]
  end

  def check_current_user
    if user_signed_in? == false
      flash[:notice] = 'Session ended, Please try to login.'
      redirect_to '/'
    else
      #session[:portal_dtr_upload_id] = 0
    end    
  end


  def workschedreport

  end


  def workschedreportpdf
    respond_to do |format|
      format.html
      format.pdf do

        render pdf: 'WorkSchedReportPDF',
               template: "portal_dhs_employee_weekly_schedule_us/workschedreportpdf.html.erb",
               formats: [:html],
               disposition: :inline,
               orientation:'Landscape',
               footer: { right: "[page] of [topage] - #{DateTime.now.strftime("%m/%d/%Y %H:%M")}" }
      end
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_dhs_employee_weekly_schedule_u
      @portal_dhs_employee_weekly_schedule_u = PortalDhsEmployeeWeeklyScheduleU.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portal_dhs_employee_weekly_schedule_u_params
      #params.fetch(:portal_dhs_employee_weekly_schedule_u, {})
      params.require(:portal_dhs_employee_weekly_schedule_u).permit(:ID, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :WorkDate, :WorkSched, :IsRD, :EmployeeRefNo, :newworksched, :sched_id, :shift_start, :shift_end, :time_in, :time_out, :task, :WorkLocationRefNo)
    end


end