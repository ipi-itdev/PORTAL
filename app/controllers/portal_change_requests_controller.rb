class PortalChangeRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_change_request, only: [:show, :edit, :update, :destroy]

  def index
    @portal_change_requests = PortalChangeRequest.find_by_sql("select * from PORTAL_EmployeeProfileChangeRequest_U where IsActive = 1 AND CreatedBy = #{current_user.EmployeeRefNo}")
  end

  def show
  end

  def new
    @portal_change_request = PortalChangeRequest.new
  end

  def edit
    @get_edit_id = PortalChangeRequest.find(params[:id])
  end

  def create
    @portal_change_request= PortalChangeRequest.new(portal_change_request_params)

    respond_to do |format|
      if @portal_change_requests.save
        format.html { redirect_to @portal_change_request}
        format.json { render :show, status: :created, location: @portal_change_request}
      else
        format.html { render :new }
        format.json { render json: @portal_change_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_change_request.update(portal_change_request_params)
        format.html { redirect_to '/portal_change_request', notice: 'Change Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_change_request }
      else
        format.html { render :edit }
        format.json { render json: @portal_change_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    portal_change_request_rec = PortalChangeRequest.where(ID: @portal_change_request.id)
      
    portal_change_request_rec.each do |portal_change_request_rec1|
      portal_change_request_rec1.FilingStatusRefNo = 3
      portal_change_request_rec1.save
    end
  
    flash[:notice] = "Record has been canceled."
    redirect_to portal_change_requests_path
  end

  def create_changerequest
      portal_change_request_save  = PortalChangeRequest.new
      portal_change_request_save.EmployeeRefNo = current_user.EmployeeRefNo
      portal_change_request_save.CreatedBy = current_user.EmployeeRefNo
      portal_change_request_save.ModifiedBy = current_user.EmployeeRefNo
      portal_change_request_save.FilingStatusRefNo = 1
      portal_change_request_save.ServerCompanyCodeID = '1-1'      
      portal_change_request_save.save

      redirect_to edit_portal_change_request_path(id: portal_change_request_save.id)
  end

  def post_changerequest
    portal_change_request_rec_checker = PortalChangeRequest.where(ID: params[:changerequest_id]).pluck(:IsActive).to_sentence

    if portal_change_request_rec_checker == 'false'
      flash[:notice] = "No details."
      redirect_to edit_portal_change_request_path(id: params[:changerequest_id])

    else  
      errmsg = ActiveRecord::Base.connection.exec_query("exec dbo.Portal_SP_ChangeRequestPost @ID = #{params[:changerequest_id]}")
       
      if errmsg.rows[0][0] != ''
        flash[:notice] = errmsg.rows[0][0]
        redirect_to edit_portal_change_request_path(id: params[:changerequest_id])

      else
        portal_change_request_rec = PortalChangeRequest.where(ID: params[:changerequest_id])
    
        portal_change_request_rec.each do |portal_change_request_rec1|
          portal_change_request_rec1.FilingStatusRefNo = 40
          portal_change_request_rec1.save
        end   

        flash[:notice] = "Record has been requested."
        redirect_to portal_change_requests_path
      end             
    end
  end

  private
    def set_portal_change_request
      @portal_change_request = PortalChangeRequest.find(params[:id])
    end

    def portal_change_request_params
      params.fetch(:portal_change_request, {}).permit(:ID, :EmployeeRefNo, :FilingStatusRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate)
    end
end