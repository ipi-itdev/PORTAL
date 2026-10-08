class ReferralsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_referral, only: [:show, :edit, :update, :destroy]
  prepend_before_action :checker_oldpass, only: [:index,:show, :edit, :new] # Change this to be any actions you want to protect.
  prepend_before_action :editmodchecker, only: [:edit, :index,:destroy] # utility to redirect when accessing these modules
  before_action :checkmyreferral, only: [:show] # Change this to be any actions you want to protect.
  prepend_before_action :checkadminloggedin


  # GET /referrals
  # GET /referrals.json
  def index
    @referrals = Referral.all
  end

  # GET /referrals/1
  # GET /referrals/1.json
  def show
  end

  # GET /referrals/new
  def new
    @current_user = current_user
    @referral = Referral.new
  end

  # GET /referrals/1/edit
  def edit


  end

  # POST /referrals
  # POST /referrals.json
  def create
      xuser = current_user.id
      yuser = User.where(id: xuser).pluck(:employeerefno).to_sentence
      zuser = yuser.to_i

      @referral = Referral.new(referral_params)
      getreferemprefno1 =  User.where(employeerefno: zuser).pluck(:employeerefno).to_sentence
      getreferemprefno = getreferemprefno1.to_i
      @payslipsettting = Payslipsetting.where(id:1).pluck(:value).to_sentence

      if @referral.employeerefno == getreferemprefno

            respond_to do |format|
              if @referral.save
                
                UserMailer.welcome_email(@referral, @payslipsettting).deliver_now
                format.html { redirect_to @referral, notice: 'Referral was successfully created.' }
                format.json { render :show, status: :created, location: @referral }
              else
                format.html { render :new }
                format.json { render json: @referral.errors, status: :unprocessable_entity }
         
              end
            end

      else
          redirect_to '/referrals/new', notice: 'Your are a ninja! :)'    
      end
  end

  # PATCH/PUT /referrals/1
  # PATCH/PUT /referrals/1.json
  def update
    respond_to do |format|
      if @referral.update(referral_params)
        format.html { redirect_to @referral, notice: 'Referral was successfully updated.' }
        format.json { render :show, status: :ok, location: @referral }
      else
        format.html { render :edit }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.json
  def destroy
    #@referral.destroy
    #respond_to do |format|
     # format.html { redirect_to referrals_url, notice: 'Referral was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referral
      @referral = Referral.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referral_params
      params.require(:referral).permit(:name, :address, :email, :phone, :skills, :remarks, :employeerefno, :contact)
    end

    

    private
    def checker_oldpass
      if current_user.blank?
        flash[:success] = "Welcome!"  
      else

        xcur = current_user.id
        ycur = User.where(id: xcur).pluck(:encrypted_password).to_sentence
        ycur1 = ycur.to_s
        zcur = "$2a$11$txIf0M5feHeEkP4KGPkdf.5RCka0DHycG.bav3oKhlhzgEj.LTeFW"

      if ycur1.to_s ==  zcur.to_s
        redirect_to '/users/password/new' and return
      else
        flash[:success] = "Welcome!"  
      
      end
    end       
    end

    private
    def editmodchecker
      redirect_to '/referrals/new', method: 'get'  
    end


    private
    def checkmyreferral
      getrefemprefno1 = @referral.employeerefno
      cur_user1 = current_user.EmployeeRefNo
      if getrefemprefno1 == cur_user1
        flash.now[:notice] = "Referral was successfully created." 
      else
        redirect_to '/referrals/new', method: 'get', notice: "Referral was successfully destroyed.2 #{getrefemprefno1} / #{cur_user1}"  
      end  
    end


  private
  def checkadminloggedin
    if user_signed_in? == false
      @getuserrefno110 = 0      
    else
      @getuserrefno110 = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:IsAdmin).to_sentence
    end	
  end
end
