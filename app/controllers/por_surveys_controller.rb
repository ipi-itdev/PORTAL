class PorSurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_por_survey, only: [:show, :edit, :update, :destroy]

  
  # GET /por_surveys
  # GET /por_surveys.json
  def index

    @EmployeeRefNo = current_user.EmployeeRefNo
   
  end

  # GET /por_surveys/1
  # GET /por_surveys/1.json
  def show
  end

  # GET /por_surveys/new
  def new
    
    surveycheck = PorSurvey.exists?(EmployeeRefNo: current_user.EmployeeRefNo)

    if surveycheck == false
      @por_survey = PorSurvey.new
    else
      redirect_to pages_path and return
    end



  end

  # GET /por_surveys/1/edit
  def edit
  end

  # POST /por_surveys
  # POST /por_surveys.json
  def create
    @por_survey = PorSurvey.new(por_survey_params)

    respond_to do |format|
      if @por_survey.save
        format.html { redirect_to pages_path, notice: 'Thank You!' }
        format.json { render :show, status: :created, location: @por_survey }
      else
        flash[:notice] = "Please complete the survey."
        format.html { render :new }
        format.json { render json: @por_survey.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /por_surveys/1
  # PATCH/PUT /por_surveys/1.json
  def update

  end

  # DELETE /por_surveys/1
  # DELETE /por_surveys/1.json
  def destroy

  end
  
  def later_answer_syssurvey
    user = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
    user.update(answer_survey_later: 1)
    session[:syssurvey_later] = true
    redirect_to '/pages'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_por_survey
      @por_survey = PorSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def por_survey_params
      params.require(:por_survey).permit(:EmployeeRefNo, :answer, :comments, :SupportFeedback, :SupportRating)
    end



end
