class RenewsController < ApplicationController
  before_action :set_renews, only: [:show, :edit, :update, :destroy]

  # GET /renews
  # GET /renews.json
  def index
    @renews = Renew.all
  end

  # GET /renews/1
  # GET /renews/1.json
  def show
  end

  # GET /renews/new
  def new
    @renews = Renew.new
  end

  # GET /renews/1/edit
  def edit
  end

  # POST /renews
  # POST /renews.json
  def create
    @renews = Renew.new(renews_params)

    respond_to do |format|
      if @renews.save
        format.html { redirect_to @renews, notice: 'Renew was successfully created.' }
        format.json { render :show, status: :created, location: @renews }
      else
        format.html { render :new }
        format.json { render json: @renews.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /renews/1
  # PATCH/PUT /renews/1.json
  def update
    respond_to do |format|
      if @renews.update(renews_params)
        format.html { redirect_to @renews, notice: 'Renew was successfully updated.' }
        format.json { render :show, status: :ok, location: @renews }
      else
        format.html { render :edit }
        format.json { render json: @renews.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /renews/1
  # DELETE /renews/1.json
  def destroy
    @renews.destroy
    respond_to do |format|
      format.html { redirect_to renews_url, notice: 'Renew was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_renews
      @renews = Renew.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def renews_params
      params.fetch(:renews, {})
    end
end
