class PorEmpmediadetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_por_empmediadetail, only: [:show, :edit, :update, :destroy]

  # GET /por_empmediadetails
  # GET /por_empmediadetails.json
  def index
      if current_user.IsAdmin == true
        @por_empmediadetails = PorEmpmediadetail.all
      else

        redirect_to pages_path

      end

  end

  # GET /por_empmediadetails/1
  # GET /por_empmediadetails/1.json
  def show
  end

  # GET /por_empmediadetails/new
  def new
    get_url_value_empmediadetails = request.original_url
    hash_url = Rack::Utils.parse_query URI("#{get_url_value_empmediadetails}").query
    hash_blank = hash_url["blank"]

    if hash_blank.blank?

      #@getempmediaID = ViewEmployeeMediaDetail.find_by_sql('SELECT *  FROM view_employee_media_details WHERE = AND starttime IS Null').pluck(:mediaid, :emp_media_details_emprefno, :title, :description, :mediapath)
      @getempmediaID = ViewEmployeeMediaDetail.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:mediaid, :emp_media_details_emprefno, :title, :description, :mediapath, :media_seq_refno)
      @por_empmediadetail = PorEmpmediadetail.new

    else
      get_user_info = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck_to_hash(:EmployeeRefNo, :last_media_refno)
      
      ##start loop
      ViewEmployeeMediaDetail.where(EmployeeRefNo: current_user.EmployeeRefNo).each do |empmediadetails|

        if empmediadetails.media_seq_refno < get_user_info[0][:last_media_refno]
          #nothing to do
        else
          @getempmediaID = ViewEmployeeMediaDetail.where(mediaid: empmediadetails.mediaid, EmployeeRefNo: empmediadetails.EmployeeRefNo).pluck(:mediaid, :emp_media_details_emprefno, :title, :description, :mediapath, :media_seq_refno)
          @por_empmediadetail = PorEmpmediadetail.new

        end

      end
      ## end loop
      

    end




  end



  # GET /por_empmediadetails/1/edit
  def edit

    @por_empmediadetail = PorEmpmediadetail.find(params[:id])
        


  end

  # POST /por_empmediadetails
  # POST /por_empmediadetails.json
  def create
    @por_empmediadetail = PorEmpmediadetail.new(por_empmediadetail_params)

    #respond_to do |format|
      if @por_empmediadetail.save
        #format.html { redirect_to @por_empmediadetail, notice: 'Por empmediadetail was successfully created.' }
        redirect_to edit_por_empmediadetail_path(@por_empmediadetail)
        #format.html { render :edit, edit_por_empmediadetail_path(por_empmediadetail) }
        #format.json { render :show, status: :created, location: @por_empmediadetail }
      else
        format.html { render :new }
        format.json { render json: @por_empmediadetail.errors, status: :unprocessable_entity }
      end
    #end
  end

  # PATCH/PUT /por_empmediadetails/1
  # PATCH/PUT /por_empmediadetails/1.json
  def update
    respond_to do |format|
      if @por_empmediadetail.update(por_empmediadetail_params)
        
        #check if there are existing media
        count_unfinished_media = ViewEmployeeMediaDetail.where(EmployeeRefNo:current_user.EmployeeRefNo, endtime: nil).where.not(starttime: nil).count
        count_new_media = ViewEmployeeMediaDetail.where(EmployeeRefNo:current_user.EmployeeRefNo, endtime: nil).count
        totalcountmedia = [count_unfinished_media, count_new_media].sum 

        if totalcountmedia.blank?
          #nothing to do
        else
          user = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
          #user.update(HadViewedMedia: 1)
          user.update(last_media_refno: @por_empmediadetail.media_seq_refno)
        end

        format.html { redirect_to pages_path, notice: 'Thank You!' }
        #format.json { render :show, status: :ok, location: @por_empmediadetail }
      else
        format.html { render :edit }
        format.json { render json: @por_empmediadetail.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /por_empmediadetails/1
  # DELETE /por_empmediadetails/1.json
  def destroy
    @por_empmediadetail.destroy
    respond_to do |format|
      format.html { redirect_to por_empmediadetails_url, notice: 'Por empmediadetail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_por_empmediadetail
      @por_empmediadetail = PorEmpmediadetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def por_empmediadetail_params
      params.require(:por_empmediadetail).permit(:employeerefno, :starttime, :timepaused, :endtime, :mediarefno, :media_seq_refno)
    end

    ##start record if record was closed on edit
    private
    def checker_if_finished

    end




end