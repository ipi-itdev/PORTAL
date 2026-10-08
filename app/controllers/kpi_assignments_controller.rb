class KpiAssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kpi_assignment, only: [:show, :edit, :update, :destroy]

  def index
    @kpi_assignments = KpiAssignment.find_by_sql("select * from PIS_KPIAssigmentDetails where FilingStatusRefNo <> 3 AND IsActive = 1 AND CreatedBy = #{current_user.EmployeeRefNo}") 
  end

  def show
  end

  def new
    @kpi_assignment = KpiAssignment.new
  end

  def edit
    @get_edit_id = KpiAssignment.find(params[:id])
    session[:kpi_employee] = @get_edit_id.employeerefno 
  end

  def create
    @kpi_assignment= KpiAssignment.new(kpi_assignment_params)

    respond_to do |format|
      if @kpi_assignments.save
        format.html { redirect_to @kpi_assignment}
        format.json { render :show, status: :created, location: @kpi_assignment}
      else
        format.html { render :new }
        format.json { render json: @kpi_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|           
      if @kpi_assignment.update(kpi_assignment_params)                                            
            flash[:notice] = 'Perfomance evaluation successfully updated'
            format.html { redirect_to edit_kpi_assignment_path(id: @kpi_assignment.id), notice: 'KPI Assignment was successfully updated.' }
      else
        format.html { render :edit}
        format.json { render json: @kpi_assignment.errors, status: :unprocessable_entity }
      end 
    end
  end

  def destroy
    ActiveRecord::Base.connection.execute("UPDATE dbo.PIS_KPIAssigmentDetails SET FilingStatusRefNo = 3 WHERE ID = #{@kpi_assignment.id}")

    flash[:notice] = "Record has been cancel."
    redirect_to kpi_assignments_path
  end

  def create_kpi
      id = ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_CreateKPI #{current_user.EmployeeRefNo}")

      redirect_to edit_kpi_assignment_path(id: id.rows[0][0])
  end

  def post_kpi    
    errmsg = ActiveRecord::Base.connection.exec_query("EXEC dbo.Portal_KPIRequest #{params[:kpi_id]}")    
      
    if errmsg.rows[0][0] != '' 
      flash[:notice] = errmsg.rows[0][0]
    else
      flash[:notice] = "Record has been requested."      
    end

    redirect_to "/kpi_assignments/#{params[:kpi_id]}/edit"
  end

  def showkpireport	
		@companycode = GenCompanyM.where(IsActive: 1).pluck(:ID).to_sentence				    
		#@Report_link = "https://kpireport.pitsph.com/Home/EvaluationReport?pkey=#{@companycode}_#{session[:kpi_assignment_id]}"
    @Report_link = "https://cpstest.pitsph.com/Home/EvaluationReport?pkey=#{@companycode}_#{session[:kpi_assignment_id]}"
    render :layout => false
	end

  private
    def set_kpi_assignment
      @kpi_assignment = KpiAssignment.find(params[:id])
    end

    def kpi_assignment_params
      params.fetch(:kpi_assignment, {}).permit(:ID, :EmployeeRefNo, :EvalPurposeRefNo, :FilingStatusRefNo, 
        :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :PerformancePercentageID, 
        :StartDate, :EndDate, :SubmissionDate, :PARRemarks, :DateSubmitted, :Remarks)    
    end
end