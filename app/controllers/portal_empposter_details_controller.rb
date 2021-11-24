class PortalEmpposterDetailsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_portal_empposter_detail, only: [:show, :edit, :update, :destroy]

  # GET /portal_empposter_details
  # GET /portal_empposter_details.json
  def index
    @portal_empposter_details = PortalEmpposterDetail.all
  end

  # GET /portal_empposter_details/1
  # GET /portal_empposter_details/1.json
  def show
  end

  # GET /portal_empposter_details/new
  def new

    #get the latest poster refno
    @check_viewed_latest_poster = PortalEmpposterDetail.where(employeerefno: current_user.EmployeeRefNo).pluck(:poster_refno).last

    #get the latest poster
    @get_latest_poster = PortalPoster.pluck(:poster_refno).last

     @get_val =  @get_latest_poster != @check_viewed_latest_poster

    if @get_val.to_s == 'true'

      get_the_next_poster = @check_viewed_latest_poster.to_i + 1

      @get_poster_not_viewed = PortalPoster.where(poster_refno: get_the_next_poster )

      @portal_empposter_detail = PortalEmpposterDetail.new


    else

      redirect_to pages_path and return

    end


  end

  # GET /portal_empposter_details/1/edit
  def edit
  end

  # POST /portal_empposter_details
  # POST /portal_empposter_details.json
  def create
    @portal_empposter_detail = PortalEmpposterDetail.new(portal_empposter_detail_params)

    respond_to do |format|
      if @portal_empposter_detail.save
        format.html { redirect_to pages_path }
        #format.json { render :show, status: :created, location: @portal_empposter_detail }
        #format.html { render :new }
      else
        format.html { render :new }
        format.json { render json: @portal_empposter_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_empposter_details/1
  # PATCH/PUT /portal_empposter_details/1.json
  def update
    respond_to do |format|
      if @portal_empposter_detail.update(portal_empposter_detail_params)
        format.html { redirect_to @portal_empposter_detail, notice: 'Portal empposter detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_empposter_detail }
      else
        format.html { render :edit }
        format.json { render json: @portal_empposter_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_empposter_details/1
  # DELETE /portal_empposter_details/1.json
  def destroy
    @portal_empposter_detail.destroy
    respond_to do |format|
      format.html { redirect_to portal_empposter_details_url, notice: 'Portal empposter detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_empposter_detail
      @portal_empposter_detail = PortalEmpposterDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_empposter_detail_params
      params.require(:portal_empposter_detail).permit(:employeerefno, :poster_refno)
    end
end
