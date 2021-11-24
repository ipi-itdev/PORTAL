class PortalLeaveStatusCsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_leave_status_c, only: [:show, :edit, :update, :destroy]

  # GET /portal_leave_status_cs
  # GET /portal_leave_status_cs.json
  def index
    @portal_leave_status_cs = PortalLeaveStatusC.all
  end

  # GET /portal_leave_status_cs/1
  # GET /portal_leave_status_cs/1.json
  def show
  end

  # GET /portal_leave_status_cs/new
  def new
    @portal_leave_status_c = PortalLeaveStatusC.new
  end

  # GET /portal_leave_status_cs/1/edit
  def edit
  end

  # POST /portal_leave_status_cs
  # POST /portal_leave_status_cs.json
  def create
    @portal_leave_status_c = PortalLeaveStatusC.new(portal_leave_status_c_params)

    respond_to do |format|
      if @portal_leave_status_c.save
        format.html { redirect_to @portal_leave_status_c, notice: 'Portal leave status c was successfully created.' }
        format.json { render :show, status: :created, location: @portal_leave_status_c }
      else
        format.html { render :new }
        format.json { render json: @portal_leave_status_c.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_leave_status_cs/1
  # PATCH/PUT /portal_leave_status_cs/1.json
  def update
    respond_to do |format|
      if @portal_leave_status_c.update(portal_leave_status_c_params)
        format.html { redirect_to @portal_leave_status_c, notice: 'Portal leave status c was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_leave_status_c }
      else
        format.html { render :edit }
        format.json { render json: @portal_leave_status_c.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_leave_status_cs/1
  # DELETE /portal_leave_status_cs/1.json
  def destroy
    @portal_leave_status_c.destroy
    respond_to do |format|
      format.html { redirect_to portal_leave_status_cs_url, notice: 'Portal leave status c was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_leave_status_c
      @portal_leave_status_c = PortalLeaveStatusC.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_leave_status_c_params
      params.require(:portal_leave_status_c).permit(:status_description, :status_refno)
    end
end
