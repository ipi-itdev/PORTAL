class KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_knowledge, only: [:show, :edit, :update, :destroy]
  #prepend_before_action :adminchecker, only: [:edit, :new] # Change this to be any actions you want to protect.
  prepend_before_action :checkadminloggedin
  prepend_before_action :privacychecker, only: [:index]
 # prepend_before_action :tempsurvey_checker, only: [:index]
  
  #before_action :checksurvey

  # GET /knowledges
  # GET /knowledges.json
  def index


    #check announcements
    @getannouncements = Announcement.where(post: true)
    @searchtrigger = 'no'

    @knowledges = if params[:search]
      #Knowledge.where('content LIKE ?', "%#{params[:search]}%")
      Knowledge.find_by_sql("select * from knowledges where title like '%#{params[:search]}%' or summary like '%#{params[:search]}%' or content like '%#{params[:search]}%' order by created_at desc")

    else
      Knowledge.all
   
    end


  end

  # GET /knowledges/1
  # GET /knowledges/1.json
  def show

  end

  # GET /knowledges/new
  def new
    @knowledge = Knowledge.new
    @usuario_actual = current_user.EmployeeRefNo

  end

  # GET /knowledges/1/edit
  def edit
    

    
  end

  # POST /knowledges
  # POST /knowledges.json
  def create
    @knowledge = Knowledge.new(knowledge_params)

    respond_to do |format|
      if @knowledge.save
        format.html { redirect_to @knowledge, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @knowledge }
      else
        @usuario_actual = current_user.EmployeeRefNo
        format.html { render "/knowledges/new" }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
        #format.html { redirect_to '/knowledges/new', status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /knowledges/1
  # PATCH/PUT /knowledges/1.json
  def update
    respond_to do |format|
      if @knowledge.update(knowledge_params)
        format.html { redirect_to @knowledge, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @knowledge }
      else
        format.html { render :edit }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knowledges/1
  # DELETE /knowledges/1.json
  def destroy
    @knowledge.destroy
    respond_to do |format|
      format.html { redirect_to knowledges_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


 
  def Covid_9_Vax_Program
    
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge
      @knowledge = Knowledge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knowledge_params
      params.require(:knowledge).permit(:title, :content, :createdby, :category, :summary,:source,:viewpdf,:attachment, :search)
    end


    def adminchecker
      #start check if SA

      if current_user.blank?
        redirect_to '/users/sign_in'
      else

        getuserrefno120 = current_user.EmployeeRefNo
        xgetuserrefno120 = SysWebUser.where(EmployeeRefNo:getuserrefno120).pluck(:UserPrivilegesRefNo).to_sentence
      
        if xgetuserrefno120 == '19'
          flash[:notice] = "Welcome Admin!"    
        else
          flash[:notice]  = "You're a Ninja!"
          redirect_to '/'
        end 

      end          
      # end checking of SA
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
