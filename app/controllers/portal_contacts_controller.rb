class PortalContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_contact, only: [:show, :edit, :update, :destroy]

  def index   
    session[:contactedit] = 1 
    @portal_contacts = PortalContact.find_by_sql("select * from PORTAL_Contact_U where IsActive = 1")
  end

  def new
    @portal_contact = PortalContact.new
  end

  def edit
    @get_edit_id = PortalContact.find(params[:id])
  end

  def update
    respond_to do |format|
      if @portal_contact.update(portal_contact_params)
        format.html { redirect_to '/portal_contact', notice: 'Personal & Contact Information was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_contact }
      else
        format.html { render :edit }
        format.json { render json: @portal_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_portal_contact
      @portal_contact = PortalContact.find(params[:id])
    end

    def portal_contact_params
      params.fetch(:portal_contact, {}).permit(:ID, :EmployeeRefNo, :DateFiled, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate)
    end
end


