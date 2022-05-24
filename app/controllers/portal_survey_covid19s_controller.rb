class PortalSurveyCovid19sController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_survey_covid19, only: [:show, :edit, :update, :destroy]


  # GET /portal_survey_covid19s
  # GET /portal_survey_covid19s.json
  def index
      if current_user.EmployeeGroupRefNo == '1' #for internal
          redirect_to pages_path and return
      else #for external
        check_covid_survey_exist = PortalSurveyCovid19.where(employeerefno: current_user.EmployeeRefNo).exists?

          if check_covid_survey_exist == true
              redirect_to pages_path and return
          else ##false
             @portal_survey_covid19s = PortalSurveyCovid19.all
          end

      end
  end

  # GET /portal_survey_covid19s/1
  # GET /portal_survey_covid19s/1.json
  def show
  end

  # GET /portal_survey_covid19s/new
  def new
      if current_user.EmployeeGroupRefNo == '1' #for internal
          redirect_to pages_path and return
      else #for external
        check_covid_survey_exist = PortalSurveyCovid19.where(employeerefno: current_user.EmployeeRefNo).exists?

          if check_covid_survey_exist == true
              redirect_to pages_path and return
          else ##false
              @portal_survey_covid19 = PortalSurveyCovid19.new
          end

      end
  end

  # GET /portal_survey_covid19s/1/edit
  def edit
  end

  # POST /portal_survey_covid19s
  # POST /portal_survey_covid19s.json
  def create
    @portal_survey_covid19 = PortalSurveyCovid19.new(portal_survey_covid19_params)

    respond_to do |format|
      if @portal_survey_covid19.save
        format.html { redirect_to pages_path, notice: 'Thank You!' }
        format.json { render :show, status: :created, location: @portal_survey_covid19 }
      else
        format.html { render :new }
        flash[:notice] = 'Please fill-up the required fields'
        format.json { render json: @portal_survey_covid19.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_survey_covid19s/1
  # PATCH/PUT /portal_survey_covid19s/1.json
  def update
    respond_to do |format|
      if @portal_survey_covid19.update(portal_survey_covid19_params)
        format.html { redirect_to @portal_survey_covid19, notice: 'Portal survey covid19 was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_survey_covid19 }
      else
        format.html { render :edit }
        format.json { render json: @portal_survey_covid19.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_survey_covid19s/1
  # DELETE /portal_survey_covid19s/1.json
  def destroy
    @portal_survey_covid19.destroy
    respond_to do |format|
      format.html { redirect_to portal_survey_covid19s_url, notice: 'Portal survey covid19 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_survey_covid19
      @portal_survey_covid19 = PortalSurveyCovid19.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_survey_covid19_params
      params.require(:portal_survey_covid19).permit(:q1_0, :q1_1, :q2_0, :q2_1, :q3_0, :q4_0, :q4_1,:q4_2,:q4_3,:q4_4,:q4_5,:q4_6,:q5_0, :q5_1, :q6_0, :q6_1, :q7_0, :q8_0, :q9_0, :q10_0, :employeerefno)
    end



end
