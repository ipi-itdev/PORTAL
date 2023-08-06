class PortalTempwebinarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_tempwebinar, only: [:show, :edit, :update, :destroy]

  # GET /portal_tempwebinars
  # GET /portal_tempwebinars.json
  def index
    #@portal_tempwebinars = PortalTempwebinar.all
    #redirect_to '/portal_tempwebinars/new'
  end

  # GET /portal_tempwebinars/1
  # GET /portal_tempwebinars/1.json
  def show
  end

  # GET /portal_tempwebinars/new
  def new


      get_fillingstatus_exists = PortalTempwebinar.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?

      if get_fillingstatus_exists == true
        flash[:notice] = "Record Already Exists1"
           redirect_to '/pages'
      else
            @portal_tempwebinar = PortalTempwebinar.new
      end


   
  end

  # GET /portal_tempwebinars/1/edit
  def edit

      @portal_tempwebinar = PortalTempwebinar.find(params[:id])

      get_emprefno = PortalTempwebinar.where(id: @portal_tempwebinar).pluck(:EmployeeRefNo).to_sentence

      if current_user.EmployeeRefNo.to_s == get_emprefno
        #nothing to do
        #flash[:notice] = "hello"
      else
        flash[:notice] = "hello#{get_emprefno}/#{current_user.EmployeeRefNo}"
        redirect_to pages_path
      end


  end

  # POST /portal_tempwebinars
  # POST /portal_tempwebinars.json
  def create
    @portal_tempwebinar = PortalTempwebinar.new(portal_tempwebinar_params)

      respond_to do |format|
        if @portal_tempwebinar.save

          format.html { redirect_to '/pages', notice: "Thank You!" }
          format.json { render :show, status: :created, location: @portal_tempwebinar }
        else
          format.html { render :new }
          format.json { render json: @portal_tempwebinar.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /portal_tempwebinars/1
  # PATCH/PUT /portal_tempwebinars/1.json
  def update
    respond_to do |format|
      if @portal_tempwebinar.update(portal_tempwebinar_params)
        format.html { redirect_to pages_path, notice: 'Registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_tempwebinar }
      else
        format.html { render :edit }
        format.json { render json: @portal_tempwebinar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_tempwebinars/1
  # DELETE /portal_tempwebinars/1.json
  def destroy
    @portal_tempwebinar.destroy
    respond_to do |format|
      format.html { redirect_to portal_tempwebinars_url, notice: 'Portal tempwebinar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  def later_reg

    #flash[:notice] = "test"

    #update last log-in
    user = User.find_by(EmployeeRefNo: current_user.EmployeeRefNo)
    user.update(webinareg_later: 1)

    redirect_to pages_path
    
  end


  
  def had_reg

    portal_webinar = PortalTempwebinar.new
    portal_webinar.EmployeeRefNo = current_user.EmployeeRefNo
    portal_webinar.Name = 'no_name'
    portal_webinar.created_at = Time.now
    portal_webinar.updated_at = Time.now
    portal_webinar.Email = 'no_email@ipiphil.com'
    portal_webinar.HadRegistered = true

    portal_webinar.save

    flash[:notice] = "Thank You"
    redirect_to pages_path

    
  end

  def cancel_webinar_reg

    get_rec_to_cancel = PortalTempwebinar.where(id: params[:id])

    get_rec_to_cancel.each do|get_rec_to_cancel|
      get_rec_to_cancel.fillingstatusrefno = 6
      get_rec_to_cancel.reason = params[:reason_tag]
      get_rec_to_cancel.updated_at = Time.now

      get_rec_to_cancel.save

    end

    redirect_to pages_path

  end


  def warning
    #empty
  end


  def create_checker

    check_employee_1 = PortalTempwebinar.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? 

    check_last_webinar = PortalTempwebinar.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:webinar_refno).last

    get_existing_id_1 = PortalTempwebinar.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:id).to_sentence

    if check_employee_1 == true && check_last_webinar == 6

      
      #redirect_to "/portal_tempwebinars/#{get_existing_id_1}/edit"
      flash[:notice] = 'Registration Already Exists'
      redirect_to pages_path
      
    else

      redirect_to '/portal_tempwebinars/new'
      
    end
    
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_tempwebinar
      @portal_tempwebinar = PortalTempwebinar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_tempwebinar_params
      params.require(:portal_tempwebinar).permit(:EmployeeRefNo, :Name, :Email, :Nickname, :Mobilenumber, :PossibleQuestion, :HadRegistered, :webinar_refno, :answer)
    end
end



