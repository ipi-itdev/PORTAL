class PortalBrgyDetailsUsController < ApplicationController
  before_action :set_portal_brgy_details_u, only: [:show, :edit, :update, :destroy]

  # GET /portal_brgy_details_us
  # GET /portal_brgy_details_us.json
  def index
    #@portal_brgy_details_us = PortalBrgyDetailsU.all
    redirect_to '/portal_brgy_details_us/new'
  end

  # GET /portal_brgy_details_us/1
  # GET /portal_brgy_details_us/1.json
  def show
  end

  # GET /portal_brgy_details_us/new
  def new
    @portal_brgy_details_u = PortalBrgyDetailsU.new
  end

  # GET /portal_brgy_details_us/1/edit
  def edit
  end

  # POST /portal_brgy_details_us
  # POST /portal_brgy_details_us.json
  def create
    @portal_brgy_details_u = PortalBrgyDetailsU.new(portal_brgy_details_u_params)

    respond_to do |format|
      if @portal_brgy_details_u.save
        format.html { redirect_to pages_path }
        format.json { render :show, status: :created, location: @portal_brgy_details_u }
      else
        format.html { render :new }
        format.json { render json: @portal_brgy_details_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_brgy_details_us/1
  # PATCH/PUT /portal_brgy_details_us/1.json
  def update
    respond_to do |format|
      if @portal_brgy_details_u.update(portal_brgy_details_u_params)
        format.html { redirect_to @portal_brgy_details_u, notice: 'Portal brgy details u was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_brgy_details_u }
      else
        format.html { render :edit }
        format.json { render json: @portal_brgy_details_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_brgy_details_us/1
  # DELETE /portal_brgy_details_us/1.json
  def destroy
    @portal_brgy_details_u.destroy
    respond_to do |format|
      format.html { redirect_to portal_brgy_details_us_url, notice: 'Portal brgy details u was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_brgy_details_u
      @portal_brgy_details_u = PortalBrgyDetailsU.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_brgy_details_u_params
      params.require(:portal_brgy_details_u).permit(:EmployeeRefNo, :EmployeeNumber, :BrgyContactNum, :DateCreated)
    end
end
