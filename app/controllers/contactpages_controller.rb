class ContactpagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contactpage, only: [:show, :edit, :update, :destroy]
  prepend_before_action :editmodchecker, only: [:edit, :index,:destroy, :show] # Change this to be any actions you want to protect.
  prepend_before_action :checkadminloggedin
  prepend_before_action :privacychecker, only: [:index, :new, :create]
 # prepend_before_action :tempsurvey_checker, only: [:index]
  #before_action :checksurvey

  # GET /contactpages
  # GET /contactpages.json
  def index
    @contactpages = Contactpage.all
  end

  # GET /contactpages/1
  # GET /contactpages/1.json
  def show
  end

  # GET /contactpages/new
  def new
    @contactpage = Contactpage.new
  end

  # GET /contactpages/1/edit
  def edit
  end

  # POST /contactpages
  # POST /contactpages.json
  def create
    @contactpage = Contactpage.new(contactpage_params)

    respond_to do |format|
      if  verify_recaptcha(model: @contactpage) && @contactpage.save
        format.html { redirect_to @contactpage, notice: 'Contactpage was successfully created.' }
        format.json { render :show, status: :created, location: @contactpage }
      else
        format.html { render :new }
        format.json { render json: @contactpage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contactpages/1
  # PATCH/PUT /contactpages/1.json
  def update
    respond_to do |format|
      if @contactpage.update(contactpage_params)
        format.html { redirect_to @contactpage, notice: 'Contactpage was successfully updated.' }
        format.json { render :show, status: :ok, location: @contactpage }
      else
        format.html { render :edit }
        format.json { render json: @contactpage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactpages/1
  # DELETE /contactpages/1.json
  def destroy
    @contactpage.destroy
    respond_to do |format|
      format.html { redirect_to contactpages_url, notice: 'Contactpage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contactpage
      @contactpage = Contactpage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contactpage_params
      params.require(:contactpage).permit(:name, :email, :subject, :message)
    end


    private
    def editmodchecker
      redirect_to '/contactpages/new'  
    end

    private
    def checkadminloggedin

      if user_signed_in? == false
        @getuserrefno110 = 0
      else
        getuserrefno110 = current_user.EmployeeRefNo
        getuserrefnoforbday = getuserrefno110
        @getuserrefno110 = User.where(EmployeeRefNo:getuserrefno110).pluck(:IsAdmin).to_sentence
      end 

    end

    ##start privacychecker
    private
    def privacychecker
      if user_signed_in? == false
      else
        isagreedprivacy = current_user.IsAgreedPrivacy
        if isagreedprivacy == true
        else
          redirect_to '/privacies/new'
        end
      end 
    end
    ##end privacychecker

    private
    def checksurvey

      if user_signed_in? == false

        redirect_to '/sign_in' and return

      else
        porsurveychecker = PorSurvey.exists?(EmployeeRefNo: current_user.EmployeeRefNo)

        if porsurveychecker == true
          
        else
          redirect_to '/por_surveys/new' and return
        end
        
      end

    end

    # start tempsurvey_checker
    private
    def tempsurvey_checker
      tempsurveycheck = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:HadSurveyed).to_sentence

        if tempsurveycheck == 'true'       
          #redirect_to '/pages' and return
        else
          redirect_to '/por_temp_surveys/new' and return
        end
      
    end
    # end tempsurvey_checker

end
