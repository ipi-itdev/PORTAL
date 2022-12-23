class PortalHomeposterUsController < ApplicationController
    before_action :authenticate_user!
  before_action :set_portal_homeposter_u, only: [:show, :edit, :update, :destroy]

  # GET /portal_homeposter_us
  # GET /portal_homeposter_us.json
  def index
    #session[:portal_homeposter_u_id] = nil 
    @portal_homeposter_us = PortalHomeposterU.all
    @portal_homehposter_details = PortalHomeposterDetail.all

  end

  # GET /portal_homeposter_us/1
  # GET /portal_homeposter_us/1.json
  def show
  end

  # GET /portal_homeposter_us/new
  def new
    @portal_homeposter_u = PortalHomeposterU.new
  end

  # GET /portal_homeposter_us/1/edit
  def edit
  end

  # POST /portal_homeposter_us
  # POST /portal_homeposter_us.json
  def create
    @portal_homeposter_u = PortalHomeposterU.new(portal_homeposter_u_params)

    respond_to do |format|
      if @portal_homeposter_u.save
        format.html { redirect_to '/portal_homeposter_us', notice: 'Saved' }
        format.json { render :show, status: :created, location: @portal_homeposter_u }
      else
        format.html { render :new }
        format.json { render json: @portal_homeposter_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_homeposter_us/1
  # PATCH/PUT /portal_homeposter_us/1.json
  def update


      respond_to do |format|
        if @portal_homeposter_u.update(portal_homeposter_u_params)
          format.html { redirect_to '/portal_homeposter_us', notice: "Saved" }
          format.json { render :show, status: :ok, location: @portal_homeposter_u }
        else
          format.html { render :edit }
          format.json { render json: @portal_homeposter_u.errors, status: :unprocessable_entity }
        end
      #end
      
    end

  end

  # DELETE /portal_homeposter_us/1
  # DELETE /portal_homeposter_us/1.json
  def destroy
    @portal_homeposter_u.destroy
    respond_to do |format|
      format.html { redirect_to portal_homeposter_us_url, notice: 'Portal homeposter u was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def remove_posterdetails
    get_homeposter_rec = PortalHomeposterDetail.where(id: params[:homeposter_detail_refno].to_i)
    get_homeposter_rec.destroy_all
    flash[:notice] = "Poster Deleted"
    redirect_to "/portal_homeposter_details?homeposter_refno=#{session[:set_base_homeposter_refno]}"
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_homeposter_u
      @portal_homeposter_u = PortalHomeposterU.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_homeposter_u_params
      params.require(:portal_homeposter_u).permit(:Description, :IsSlides, :IsVisible, :HomePosterRefno, :StartDate, :EndDate)
    end
end
