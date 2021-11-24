class PortalLeaveTimeLookupUsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_leave_time_lookup_u, only: [:show, :edit, :update, :destroy]

  # GET /portal_leave_time_lookup_us
  # GET /portal_leave_time_lookup_us.json
  def index
    @portal_leave_time_lookup_us = PortalLeaveTimeLookupU.all
  end

  # GET /portal_leave_time_lookup_us/1
  # GET /portal_leave_time_lookup_us/1.json
  def show
  end

  # GET /portal_leave_time_lookup_us/new
  def new
    @portal_leave_time_lookup_u = PortalLeaveTimeLookupU.new
  end

  # GET /portal_leave_time_lookup_us/1/edit
  def edit
  end

  # POST /portal_leave_time_lookup_us
  # POST /portal_leave_time_lookup_us.json
  def create
    @portal_leave_time_lookup_u = PortalLeaveTimeLookupU.new(portal_leave_time_lookup_u_params)

    respond_to do |format|
      if @portal_leave_time_lookup_u.save
        format.html { redirect_to @portal_leave_time_lookup_u, notice: 'Portal leave time lookup u was successfully created.' }
        format.json { render :show, status: :created, location: @portal_leave_time_lookup_u }
      else
        format.html { render :new }
        format.json { render json: @portal_leave_time_lookup_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_leave_time_lookup_us/1
  # PATCH/PUT /portal_leave_time_lookup_us/1.json
  def update
    respond_to do |format|
      if @portal_leave_time_lookup_u.update(portal_leave_time_lookup_u_params)
        format.html { redirect_to @portal_leave_time_lookup_u, notice: 'Portal leave time lookup u was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_leave_time_lookup_u }
      else
        format.html { render :edit }
        format.json { render json: @portal_leave_time_lookup_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_leave_time_lookup_us/1
  # DELETE /portal_leave_time_lookup_us/1.json
  def destroy
    @portal_leave_time_lookup_u.destroy
    respond_to do |format|
      format.html { redirect_to portal_leave_time_lookup_us_url, notice: 'Portal leave time lookup u was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_leave_time_lookup_u
      @portal_leave_time_lookup_u = PortalLeaveTimeLookupU.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_leave_time_lookup_u_params
      params.require(:portal_leave_time_lookup_u).permit(:description, :leavetimelookup_refno, :leave_value)
    end
end
