class TexxtsController < ApplicationController
  before_action :set_texxt, only: [:show, :edit, :update, :destroy]

  # GET /texxts
  # GET /texxts.json
  def index
    @texxts = Texxt.all
  end

  # GET /texxts/1
  # GET /texxts/1.json
  def show
  end

  # GET /texxts/new
  def new
    @texxt = Texxt.new
  end

  # GET /texxts/1/edit
  def edit
  end

  # POST /texxts
  # POST /texxts.json
  def create
    @texxt = Texxt.new(texxt_params)

    respond_to do |format|
      if @texxt.save
        format.html { redirect_to @texxt, notice: 'Texxt was successfully created.' }
        format.json { render :show, status: :created, location: @texxt }
      else
        format.html { render :new }
        format.json { render json: @texxt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texxts/1
  # PATCH/PUT /texxts/1.json
  def update
    respond_to do |format|
      if @texxt.update(texxt_params)
        format.html { redirect_to @texxt, notice: 'Texxt was successfully updated.' }
        format.json { render :show, status: :ok, location: @texxt }
      else
        format.html { render :edit }
        format.json { render json: @texxt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texxts/1
  # DELETE /texxts/1.json
  def destroy
    @texxt.destroy
    respond_to do |format|
      format.html { redirect_to texxts_url, notice: 'Texxt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_texxt
      @texxt = Texxt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def texxt_params
      params.fetch(:texxt, {})
    end
end
