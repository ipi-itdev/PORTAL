class PortalPostersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_portal_poster, only: [:show, :edit, :update, :destroy]

  # GET /portal_posters
  # GET /portal_posters.json
  def index
    @portal_posters = PortalPoster.all
  end

  # GET /portal_posters/1
  # GET /portal_posters/1.json
  def show
  end

  # GET /portal_posters/new
  def new
    @portal_poster = PortalPoster.new
  end

  # GET /portal_posters/1/edit
  def edit
  end

  # POST /portal_posters
  # POST /portal_posters.json
  def create
    @portal_poster = PortalPoster.new(portal_poster_params)

    respond_to do |format|
      if @portal_poster.save
        format.html { redirect_to @portal_poster, notice: 'Portal poster was successfully created.' }
        format.json { render :show, status: :created, location: @portal_poster }
      else
        format.html { render :new }
        format.json { render json: @portal_poster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_posters/1
  # PATCH/PUT /portal_posters/1.json
  def update
    respond_to do |format|
      if @portal_poster.update(portal_poster_params)
        format.html { redirect_to @portal_poster, notice: 'Portal poster was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_poster }
      else
        format.html { render :edit }
        format.json { render json: @portal_poster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_posters/1
  # DELETE /portal_posters/1.json
  def destroy
    @portal_poster.destroy
    respond_to do |format|
      format.html { redirect_to portal_posters_url, notice: 'Portal poster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_poster
      @portal_poster = PortalPoster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_poster_params
      params.require(:portal_poster).permit(:description, :date_post, :poster_refno, :attachedfile)
    end
end
