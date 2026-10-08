class PortalHomeposterDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_homeposter_detail, only: [:show, :edit, :update, :destroy]

  # GET /portal_homeposter_details
  # GET /portal_homeposter_details.json
  def index
    @hash_url_poster_details = request.params 
    @portal_homeposter_details = PortalHomeposterDetail.where(HomePosterRefno: @hash_url_poster_details[:homeposter_refno] )
    session[:set_base_homeposter_refno] = @hash_url_poster_details[:homeposter_refno]
    @get_last_seq = PortalHomeposterDetail.where(HomePosterRefno: session[:set_base_homeposter_refno].to_i).pluck(:SeqNumber).to_sentence.last
    render :layout => false
  end

  # GET /portal_homeposter_details/1
  # GET /portal_homeposter_details/1.json
  def show
  end

  # GET /portal_homeposter_details/new
  def new
    @hash_url_poster_details = request.params
    session[:set_base_homeposter_refno] = @hash_url_poster_details[:homeposter_refno]    
    @portal_homeposter_detail = PortalHomeposterDetail.new
    render :layout => false
  end

  # GET /portal_homeposter_details/1/edit
  def edit
    @hash_url_poster_details = request.params
    session[:set_base_homeposter_refno] = @hash_url_poster_details[:homeposter_refno]  
    render :layout => false
  end

  # POST /portal_homeposter_details
  # POST /portal_homeposter_details.json
  def create
    @portal_homeposter_detail = PortalHomeposterDetail.new(portal_homeposter_detail_params)
    get_HomePosterRefno = @portal_homeposter_detail.HomePosterRefno

    respond_to do |format|
      if @portal_homeposter_detail.save
        format.html { redirect_to "/portal_homeposter_details?homeposter_refno=#{get_HomePosterRefno}", notice: "Poster was successfully created." }
        format.json { render :show, status: :created, location: @portal_homeposter_detail }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @portal_homeposter_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_homeposter_details/1
  # PATCH/PUT /portal_homeposter_details/1.json
  def update
    respond_to do |format|
      get_HomePosterRefno = @portal_homeposter_detail.HomePosterRefno
      if @portal_homeposter_detail.update(portal_homeposter_detail_params)
        format.html { redirect_to "/portal_homeposter_details?homeposter_refno=#{get_HomePosterRefno}", notice: 'Poster was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_homeposter_detail }
      else
        format.html { render :edit,  :layout => false }
        format.json { render json: @portal_homeposter_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_homeposter_details/1
  # DELETE /portal_homeposter_details/1.json
  def destroy
    @portal_homeposter_detail.destroy
    respond_to do |format|
      format.html { redirect_to portal_homeposter_details_url, notice: 'Portal homeposter detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_homeposter_detail
      @portal_homeposter_detail = PortalHomeposterDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_homeposter_detail_params
      params.require(:portal_homeposter_detail).permit(:Description, :SeqNumber, :IsActive, :Image, :HomePosterRefno, :id)
    end





end


