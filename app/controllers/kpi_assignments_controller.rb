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
        ActiveRecord::Base.connection.exec_query("EXEC dbo.pReplaceKPIList #{@kpi_assignment.id}, 477, #{current_user.EmployeeRefNo}")

        flash[:notice] = "Record has been updated."
        redirect_to edit_kpi_assignment_path(id: @kpi_assignment.id)
        #format.html { redirect_to '/kpi_assignment', notice: 'KPI Assignment was successfully updated.' }
        #format.json { render :show, status: :ok, location: @kpi_assignment }
      else
        format.html { render :edit }
        format.json { render json: @kpi_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #ActiveRecord::Base.connection.execute("exec dbo.TMS_SP_TMSCancel @Type = 'leave', @ID = #{@kpi_assignment.id}")
    ActiveRecord::Base.connection.execute("exec dbo.pTMSApplicationApproval @TMSType = 2, @ID = #{@kpi_assignment.id}, @UserRefNo = -1, @Status = 3, @Remarks = ''")

    flash[:notice] = "Record has been cancel."
    redirect_to kpi_assignments_path
  end

  def create_assignment
      kpi_assignment_save  = KpiAssignment.new
      kpi_assignment_save.CreatedBy = current_user.EmployeeRefNo
      kpi_assignment_save.ModifiedBy = current_user.EmployeeRefNo   
      kpi_assignment_save.save

      kpi_coreresult_save = KpiCoreCompetencyResult.new
      kpi_coreresult_save.KPIAssignmentDetailsRefNo = kpi_assignment_save.id
      kpi_coreresult_save.save

      redirect_to edit_kpi_assignment_path(id: kpi_assignment_save.id)
  end

  def kpicorecompetency
    render :layout => false
  end

  private
    def set_kpi_assignment
      @kpi_assignment = KpiAssignment.find(params[:id])
    end

    def kpi_assignment_params
      params.fetch(:kpi_assignment, {}).permit(:ID, :EmployeeRefNo, :EvalPurposeRefNo, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :PerformancePercentageID, :StartDate, :EndDate, :SubmissionDate, :PARRemarks, 
        :CoreCompetencyDetailsRefNo11)    
    end
end