class PortalEmpposterDetailsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_portal_empposter_detail, only: [:show, :edit, :update, :destroy]

  # GET /portal_empposter_details
  # GET /portal_empposter_details.json
  def index
    
  end

  # GET /portal_empposter_details/1
  # GET /portal_empposter_details/1.json
  def show
  end

  # GET /portal_empposter_details/new
  def new

  end

  # GET /portal_empposter_details/1/edit
  def edit
    #get latest poster on the month

    get_latest_poster_details1 = PortalPoster.find_by_sql("select  top 1 * from portal_posters pp where start_date BETWEEN (SELECT DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)) and (select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime) ) order by start_date DESC ").pluck(:id, :poster_refno, :attachedfile)
    @get_latest_poster_details = get_latest_poster_details1[0]


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
        format.html { redirect_to '/pages'}
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
