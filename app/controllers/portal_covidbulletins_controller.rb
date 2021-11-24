class PortalCovidbulletinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_covidbulletin, only: [:show, :edit, :update, :destroy]

  # GET /portal_covidbulletins/new
  def new

    get_emp_exists = PortalCovidbulletin.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?

    if get_emp_exists == true
      redirect_to '/pages'
    else  
      @portal_covidbulletin = PortalCovidbulletin.new
    end

  end

  # POST /portal_covidbulletins
  # POST /portal_covidbulletins.json
  def create
    @portal_covidbulletin = PortalCovidbulletin.new(portal_covidbulletin_params)

    respond_to do |format|
      if @portal_covidbulletin.save
        format.html { redirect_to '/pages' }
        format.json { render :show, status: :created, location: @portal_covidbulletin }
      else
        format.html { render :new }
        format.json { render json: @portal_covidbulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_covidbulletin
      @portal_covidbulletin = PortalCovidbulletin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_covidbulletin_params
      params.require(:portal_covidbulletin).permit(:EmployeeRefNo, :EmployeeNumber)
    end
end
