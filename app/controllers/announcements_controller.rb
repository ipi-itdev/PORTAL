class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  #prepend_before_action :adminchecker, only: [:index,:show, :edit, :new] # Change this to be any actions you want to protect.
  prepend_before_action :checkadminloggedin

  

  # GET /announcements
  # GET /announcements.json
  def index
    #@announcements = Announcement.all
    @announcements = Announcement.find_by_sql("SELECT * FROM PORTAL_Announcements_U  WHERE  post = 1 and EmployeeRefNo = #{current_user.EmployeeRefNo} UNION SELECT * FROM PORTAL_Announcements_U  WHERE  post = 1 AND EmployeeRefNo IS NULL")

  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:title, :message,:post, :IsImportant)
    end

    private

    def adminchecker
      #start check if SA
  
        getuserrefno120 = current_user.EmployeeRefNo
        xgetuserrefno120 = SysWebUser.where(EmployeeRefNo:getuserrefno120).pluck(:UserPrivilegesRefNo).to_sentence
      
      if xgetuserrefno120 == '19'
        #flash[:notice] = "Welcome Admin!"    
      else
        flash[:notice]  = "You're a Ninja!"
        redirect_to '/'
      end 

      # end checking of SA

    end

    #start check if Admin for Admin Utilities
    private
      def checkadminloggedin

      if user_signed_in? == false
        @getuserrefno110 = 0
        
      else
        getuserrefno110x = current_user.EmployeeRefNo
        @getuserrefno110 = User.where(EmployeeRefNo: getuserrefno110x).pluck(:IsAdmin).to_sentence
      end 

    end

    # end check if Admin for Admin Utilities




end
