class PorMediaController < ApplicationController
  before_action :set_por_medium, only: [:show, :edit, :update, :destroy]

  # GET /por_media
  # GET /por_media.json
  def index
    @por_media = PorMedium.all
  end

  # GET /por_media/1
  # GET /por_media/1.json
  def show
  end

  # GET /por_media/new
  def new
    @por_medium = PorMedium.new
  end

  # GET /por_media/1/edit
  def edit
  end

  # POST /por_media
  # POST /por_media.json
  def create
    @por_medium = PorMedium.new(por_medium_params)

    respond_to do |format|
      if @por_medium.save
        format.html { redirect_to @por_medium, notice: 'New Media was successfully created.' }
        format.json { render :show, status: :created, location: @por_medium }
      else
        format.html { render :new }
        format.json { render json: @por_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /por_media/1
  # PATCH/PUT /por_media/1.json
  def update
    respond_to do |format|
      if @por_medium.update(por_medium_params)
        format.html { redirect_to @por_medium, notice: 'Media was successfully updated.' }
        format.json { render :show, status: :ok, location: @por_medium }
      else
        format.html { render :edit }
        format.json { render json: @por_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /por_media/1
  # DELETE /por_media/1.json
  def destroy
    @por_medium.destroy
    respond_to do |format|
      format.html { redirect_to por_media_url, notice: 'Media was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_por_medium
      @por_medium = PorMedium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def por_medium_params
      params.require(:por_medium).permit(:title, :description, :mediapath, :isactive, :mediarefno, :isrequired, :media_seq_refno)
    end
end
