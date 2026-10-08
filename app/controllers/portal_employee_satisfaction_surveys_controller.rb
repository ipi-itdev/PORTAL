class PortalEmployeeSatisfactionSurveysController < ApplicationController
  before_action :set_portal_employee_satisfaction_survey, only: [:show, :edit, :update, :destroy]

  # GET /portal_employee_satisfaction_surveys
  # GET /portal_employee_satisfaction_surveys.json
  def index
    @portal_employee_satisfaction_surveys = PortalEmployeeSatisfactionSurvey.all
  end


  # GET /portal_employee_satisfaction_surveys/new
  def new
    empsatissurveycheck = PortalEmployeeSatisfactionSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?
    if empsatissurveycheck == true
      redirect_to '/pages' and return
    else   
       @portal_employee_satisfaction_survey = PortalEmployeeSatisfactionSurvey.new
    end
  end



  # POST /portal_employee_satisfaction_surveys
  # POST /portal_employee_satisfaction_surveys.json
  def create
    @portal_employee_satisfaction_survey = PortalEmployeeSatisfactionSurvey.new(portal_employee_satisfaction_survey_params)

    respond_to do |format|
      if @portal_employee_satisfaction_survey.save
        format.html { redirect_to '/thank_you' }
        format.json { render :show, status: :created, location: @portal_employee_satisfaction_survey }
      else
        format.html { render :new }
        format.json { render json: @portal_employee_satisfaction_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_employee_satisfaction_surveys/1
  # PATCH/PUT /portal_employee_satisfaction_surveys/1.json
  def update
    respond_to do |format|
      if @portal_employee_satisfaction_survey.update(portal_employee_satisfaction_survey_params)
        format.html { redirect_to @portal_employee_satisfaction_survey, notice: 'Portal employee satisfaction survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_employee_satisfaction_survey }
      else
        format.html { render :edit }
        format.json { render json: @portal_employee_satisfaction_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_employee_satisfaction_surveys/1
  # DELETE /portal_employee_satisfaction_surveys/1.json
  def destroy
    @portal_employee_satisfaction_survey.destroy
    respond_to do |format|
      format.html { redirect_to portal_employee_satisfaction_surveys_url, notice: 'Portal employee satisfaction survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_employee_satisfaction_survey
      @portal_employee_satisfaction_survey = PortalEmployeeSatisfactionSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_employee_satisfaction_survey_params
      params.require(:portal_employee_satisfaction_survey).permit(:EmployeeRefNo, :Q1, :C1, :Q2, :C2, :Q3, :C3, :Q4, :C4, :Q5, :C5, :Q6, :C6, :Q7, :C7, :Q8, :C8, :Q9, :C9, :Q10, :C10, :Q11, :C11, :Q12, :C12, :Q13, :C13, :Q14, :C14, :Q15, :C15, :Q16, :C16, :C17, :C18 )
    end
end
