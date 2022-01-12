class WeeklySchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weekly_schedule, only: [:edit]

  def index
    @weekly_schedules = WeeklySchedule.find_by_sql("select * from dbo.TMS_FN_GetEmployeeForRemark(#{current_user.EmployeeRefNo})")
  end

  def edit
    @get_edit_id = WeeklySchedule.find(params[:id])    
  end

<<<<<<< HEAD
=======
  def dtrreport
    @get_employee_ref_no = session[:weekly_schedule_employeerefno]
    @get_existing_sched = DtrApprove.where(WorkDate: (params[:WorkDateFrom])..params[:WorkDateTo], EmployeeRefNo: session[:weekly_schedule_employeerefno] ).order(:WorkDate)
  
      #set workdate
      @get_count_existing_sched = @get_existing_sched.count
  
      if @get_count_existing_sched <= 0
        #nothing to do
      else    
        session[:WorkDateFrom_session] = params[:WorkDateFrom]
        session[:WorkDateTo_session] = params[:WorkDateTo]
  
        @get_worksched_pdf_path = "/weekly_schedules/#{@get_existing_sched.ids.first}.pdf"   
      end
  end

  def show
    render :layout => false

    @emprefno = session[:weekly_schedule_employeerefno]
    @set_workdate_from = session[:WorkDateFrom_session]   
    @set_workdate_to = session[:WorkDateTo_session]

    #generate pdf section start here
    respond_to do |pdfformat|
            pdfformat.html
            pdfformat.pdf do
              pdf = Weeksched.new(@emprefno, @set_workdate_from, @set_workdate_to )
              send_data pdf.render, filename: "timesheet.pdf", type: "application/pdf", disposition: "inline"
          end
        end
    #pdf generation ends here
  end

>>>>>>> 890d5edb... DTR Update: DTR Report Update
  private
    def set_weekly_schedule
      @weekly_schedule = WeeklySchedule.find(params[:id])
    end

    def weekly_schedule_params
      params.fetch(:weekly_schedule, {}).permit(:ID, :EmployeeRefNo, :EmployeeNumber, :Description, :JobPosition, :UserRefNo)
    end
end