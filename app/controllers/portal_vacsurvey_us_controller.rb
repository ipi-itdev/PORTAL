class PortalVacsurveyUsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_vacsurvey_u, only: [:show, :edit, :update, :destroy]

  # GET /portal_vacsurvey_us
  # GET /portal_vacsurvey_us.json
  def index
    @portal_vacsurvey_us = PortalVacsurveyU.all
  end

  # GET /portal_vacsurvey_us/1
  # GET /portal_vacsurvey_us/1.json
  def show
  end

  # GET /portal_vacsurvey_us/new
  def new

       get_vacsuvey_exist =  PortalVacsurveyU.where(EmployeeRefNo:current_user.EmployeeRefNo).exists?

       if get_vacsuvey_exist == true
          redirect_to '/pages'
       else
          @portal_vacsurvey_u = PortalVacsurveyU.new
       end

  end

  # GET /portal_vacsurvey_us/1/edit
  def edit
  end

  # POST /portal_vacsurvey_us
  # POST /portal_vacsurvey_us.json
  def create
    @portal_vacsurvey_u = PortalVacsurveyU.new(portal_vacsurvey_u_params)

    respond_to do |format|
      if @portal_vacsurvey_u.save
        format.html { redirect_to '/pages', notice: 'Thank You' }
        format.json { render :show, status: :created, location: @portal_vacsurvey_u }
      else
        format.html { render :new }
        format.json { render json: @portal_vacsurvey_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_vacsurvey_us/1
  # PATCH/PUT /portal_vacsurvey_us/1.json
  def update
    respond_to do |format|
      if @portal_vacsurvey_u.update(portal_vacsurvey_u_params)
        format.html { redirect_to @portal_vacsurvey_u, notice: 'Portal vacsurvey u was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_vacsurvey_u }
      else
        format.html { render :edit }
        format.json { render json: @portal_vacsurvey_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_vacsurvey_us/1
  # DELETE /portal_vacsurvey_us/1.json
  def destroy
    @portal_vacsurvey_u.destroy
    respond_to do |format|
      format.html { redirect_to portal_vacsurvey_us_url, notice: 'Portal vacsurvey u was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  ##vacsurvey page
  def vacsurvey
        if current_user.IsDoneVacSurvey == true
          redirect_to '/pages'
        else
          @vacsurvey_link = "https://vactest.pitsph.com/#?pkey=1_#{current_user.EmployeeRefNo}_0"
        end

  end
  ##vacsurvey page



def vacdepsurvey

  get_vacdepsuvey_exist =  PortalVacsurveyU.where(EmployeeRefNo:current_user.EmployeeRefNo, HasDependents: 1).exists?

   if get_vacdepsuvey_exist == true
      @vacdepsurvey_link = "https://vactest.pitsph.com/Home/Dependents#?pkey=1_#{current_user.EmployeeRefNo}_0"
   else
      redirect_to '/pages'
   end

  
end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_vacsurvey_u
      @portal_vacsurvey_u = PortalVacsurveyU.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_vacsurvey_u_params
      params.require(:portal_vacsurvey_u).permit(:EmployeeRefNo, :answer, :reason)
    end
end
