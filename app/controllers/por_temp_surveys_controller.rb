class PorTempSurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_por_temp_survey, only: [:show, :edit, :update, :destroy]

  # GET /por_temp_surveys
  # GET /por_temp_surveys.json
  def index
    @por_temp_surveys = PorTempSurvey.all
    redirect_to new_por_temp_survey_path and return
  end

  # GET /por_temp_surveys/1
  # GET /por_temp_surveys/1.json
  def show
  end
  
  # GET /por_temp_surveys/new
  def new

        tempsurveycheck = PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?

        if tempsurveycheck == true       
          
          redirect_to '/pages' and return
          
        else   
          @por_temp_survey = PorTempSurvey.new
    
        end

  end

  # GET /por_temp_surveys/1/edit
  def edit
  end

  # POST /por_temp_surveys
  # POST /por_temp_surveys.json
  def create
    @por_temp_survey = PorTempSurvey.new(por_temp_survey_params)

    respond_to do |format|
      if @por_temp_survey.save
      user = User.find_by(EmployeeRefNo: @por_temp_survey.EmployeeRefNo) 
      user.update(HadSurveyed: 1) 
        format.html { redirect_to '/thank_you' }
        format.json { render :show, status: :created, location: @por_temp_survey }
      else
        flash[:notice] = "Please complete the Survey"
        format.html { render :new }
        format.json { render json: @por_temp_survey.errors, status: :unprocessable_entity }
      end
    end
  end


  def ans_later

    get_date_plus_7days = Date.today + 7.days
    get_ans_later_date = Date.today
    user = User.where(EmployeeRefNo: current_user.EmployeeRefNo)

    user.update(answer_survey_later: 1, LaterSurveyDate: get_date_plus_7days, AnsweredLaterDate: get_ans_later_date)

    redirect_to pages_path
    
  end

  def no_option

    user = User.where(EmployeeRefNo: current_user.EmployeeRefNo)

    user.update(no_survey: 1)

    redirect_to pages_path
    
  end


  def thank_you

  end

  def hrc_effectiveness_survey
    temp_surveycheck = PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?

    if temp_surveycheck == true       
      redirect_to '/pages' and return
    else   
      #nothing to do
    end

  end

  
  #winner page
  def winner
    #winner page
  end
  #winner page


  #confirm winner
  def confirm_winner
    update_user_tagconfirm = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
    update_user_tagconfirm.update(TagConfirmed: 1)
    redirect_to pages_path
  end
  #confirm winner

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_por_temp_survey
      @por_temp_survey = PorTempSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def por_temp_survey_params
      params.require(:por_temp_survey).permit(:EmployeeRefNo, :Q1, :C1, :Q2, :C2, :Q3, :C3, :Q4, :C4, :Q5, :C5, :Q6, :C6, :Q7, :C7, :Q8, :C8, :Q9, :C9, :Q10, :C10, :Q11, :C11, :Q12, :C12, :Q13, :C13, :Q14, :C14, :Q15, :C15, :Q16, :C16, :C17, :C18, :emp1, :emp_desc1, :emp2, :emp_desc2, :emp3, :emp_desc3, :emp4, :emp_desc4, :emp5, :emp_desc5, :emp6, :emp_desc6,:emp7, :emp_desc7,:emp8, :emp_desc8)
    end
end
