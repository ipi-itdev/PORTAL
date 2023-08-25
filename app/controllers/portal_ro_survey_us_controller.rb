class PortalRoSurveyUsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_ro_survey_u, only: [:show, :edit, :update, :destroy]

  # GET /portal_ro_survey_us
  # GET /portal_ro_survey_us.json
  def index
    @portal_ro_survey_us = PortalRoSurveyU.all
  end

  # GET /portal_ro_survey_us/1
  # GET /portal_ro_survey_us/1.json
  def show
  end

  # GET /portal_ro_survey_us/new
  def new

        if current_user.IsDoneROS == true
          redirect_to pages_path
        else
          @portal_ro_survey_u = PortalRoSurveyU.new
        end

  end

  # GET /portal_ro_survey_us/1/edit
  def edit
  end

  # POST /portal_ro_survey_us
  # POST /portal_ro_survey_us.json
  def create
    @portal_ro_survey_u = PortalRoSurveyU.new(portal_ro_survey_u_params)

    respond_to do |format|
      if @portal_ro_survey_u.save

        get_emp = User.where(EmployeeRefNo: @portal_ro_survey_u.EmployeeRefNo)
        get_emp.update(IsDoneROS: true)

        format.html { redirect_to pages_path, notice: 'Thank You.' }
        format.json { render :show, status: :created, location: @portal_ro_survey_u }
      else
        format.html { render :new }
        format.json { render json: @portal_ro_survey_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_ro_survey_us/1
  # PATCH/PUT /portal_ro_survey_us/1.json
  def update
    respond_to do |format|
      if @portal_ro_survey_u.update(portal_ro_survey_u_params)
        format.html { redirect_to @portal_ro_survey_u, notice: 'Portal ro survey u was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_ro_survey_u }
      else
        format.html { render :edit }
        format.json { render json: @portal_ro_survey_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_ro_survey_us/1
  # DELETE /portal_ro_survey_us/1.json
  def destroy
    @portal_ro_survey_u.destroy
    respond_to do |format|
      format.html { redirect_to portal_ro_survey_us_url, notice: 'Portal ro survey u was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_ro_survey_u
      @portal_ro_survey_u = PortalRoSurveyU.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_ro_survey_u_params
      params.require(:portal_ro_survey_u).permit(:EmployeeRefNo, :Q1, :Q2, :Q3, :Q4a, :Q4b, :Q4c, :Q5, :Q6, :Q7, :Q8, :Q9a, :Q9b, :Q9c, :Q10, :Q11, :Q12a, :Q12b, :Q12c, :Q13, :Q14, :Q15, :Q16, :Q17, :Q18, :Q19, :Q20, :DateCreated)
    end
end


