class PortalDtrHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_dtr_history, only: [:edit]

  def index
    @portal_dtr_histories = PortalDtrHistory.find_by_sql("select * from dbo.TMS_FN_DTREmployeeList(#{current_user.EmployeeRefNo})")
  end

  def dtrreport
    @get_employee_ref_no = session[:portal_dtr_history_employeerefno]
    @get_existing_sched = DtrApprove.where(WorkDate: (params[:WorkDateFrom])..params[:WorkDateTo], EmployeeRefNo: session[:portal_dtr_history_employeerefno]).order(:WorkDate)
  
      #set workdate
      @get_count_existing_sched = @get_existing_sched.count
  
      if @get_count_existing_sched <= 0
        #nothing to do
      else    
        session[:WorkDateFrom_session] = params[:WorkDateFrom]
        session[:WorkDateTo_session] = params[:WorkDateTo]
  
        @get_worksched_pdf_path = "/portal_dtr_historys/#{@get_existing_sched.ids.first}.pdf"   
      end
  end

  def show
    render :layout => false

    @emprefno = session[:portal_dtr_history_employeerefno]
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


  def login_logs
      @employeelist = PisEmploymentInfoU.find_by_sql("SELECT PIS_EmploymentInfo_U.*, PIS_Employee_U.Description as EMPDESC, PIS_Employee_U.FullName FROM PIS_EmploymentInfo_U INNER JOIN PIS_Employee_U ON PIS_EmploymentInfo_U.EmployeeRefNo = PIS_Employee_U.EmployeeRefNo WHERE  ClientAccountRefNo IN (180, 181, 1390,1391, 179,2432,3490) AND PIS_EmploymentInfo_U.IsActive = 1")
  end

  def login_report
    if params[:LoginFrom] == '' || params[:LoginTo] == ''
        get_loginfrom = ''
        get_loginto = ''
        session[:loginlog_emprefno] = params[:login_report_emprefno]
        @login_ouput = PortalLoginLog.where(EmployeeRefNo: params[:loginlogs_employeerefno], Time_Login: get_loginfrom..get_loginto)

    else
      if params[:firstlog_load] == 'true'
        get_loginfrom = params[:LoginFrom]
        get_loginto = params[:LoginTo]
        @login_ouput = PortalLoginLog.where(EmployeeRefNo: params[:loginlogs_employeerefno], Time_Login: get_loginfrom..get_loginto)

      else
        get_loginfrom = params[:LoginFrom]
        get_loginto1 = params[:LoginTo]
        get_loginto2 = get_loginto1.to_date + 24.hours + 59.minutes + 59.seconds
        session[:loginlog_emprefno] = params[:login_report_emprefno]
        @login_ouput = PortalLoginLog.where(EmployeeRefNo: session[:loginlog_emprefno], Time_Login: get_loginfrom..get_loginto2).order(:Time_Login)
      end      
    end
  end


  private
    def set_portal_dtr_history
      @portal_dtr_history = PortalDtrHistory.find(params[:id])
    end

    def portal_dtr_history_params
      params.fetch(:portal_dtr_history, {}).permit(:ID, :EmployeeRefNo, :EmployeeNumber, :Description, :JobPosition, :UserRefNo)
    end
end