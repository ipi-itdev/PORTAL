class UserherosController < ApplicationController
  before_action :set_userhero, only: [:show, :edit, :update, :destroy]

  # GET /userheros
  # GET /userheros.json
  def index
    @userheros = Userhero.all
  end

  # GET /userheros/1
  # GET /userheros/1.json
  def show
  end

  # GET /userheros/new
  def new
    @userhero = Userhero.new
  end

  # GET /userheros/1/edit
  def edit
  end

  # POST /userheros
  # POST /userheros.json
  def create
    @userhero = Userhero.new(userhero_params)

    respond_to do |format|
      if @userhero.save
        UserMailer.with(user: @userhero).welcome_email.deliver_later
        format.html { redirect_to @userhero, notice: 'Userhero was successfully created.' }
        format.json { render :show, status: :created, location: @userhero }
      else
        format.html { render :new }
        format.json { render json: @userhero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userheros/1
  # PATCH/PUT /userheros/1.json
  def update
    respond_to do |format|
      if @userhero.update(userhero_params)
        format.html { redirect_to @userhero, notice: 'Userhero was successfully updated.' }
        format.json { render :show, status: :ok, location: @userhero }
      else
        format.html { render :edit }
        format.json { render json: @userhero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userheros/1
  # DELETE /userheros/1.json
  def destroy
    @userhero.destroy
    respond_to do |format|
      format.html { redirect_to userheros_url, notice: 'Userhero was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userhero
      @userhero = Userhero.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userhero_params
      params.require(:userhero).permit(:name, :email, :login)
    end
end
