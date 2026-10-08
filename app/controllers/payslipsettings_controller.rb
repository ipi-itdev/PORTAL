class PayslipsettingsController < ApplicationController
  before_action :set_payslipsetting, only: [:show, :edit, :update, :destroy]

  # GET /payslipsettings
  # GET /payslipsettings.json
  def index
    @payslipsettings = Payslipsetting.all
  end

  # GET /payslipsettings/1
  # GET /payslipsettings/1.json
  def show
  end

  # GET /payslipsettings/new
  def new
    @payslipsetting = Payslipsetting.new
  end

  # GET /payslipsettings/1/edit
  def edit
  end

  # POST /payslipsettings
  # POST /payslipsettings.json
  def create
    @payslipsetting = Payslipsetting.new(payslipsetting_params)

    respond_to do |format|
      if @payslipsetting.save
        format.html { redirect_to @payslipsetting, notice: 'Payslipsetting was successfully created.' }
        format.json { render :show, status: :created, location: @payslipsetting }
      else
        format.html { render :new }
        format.json { render json: @payslipsetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payslipsettings/1
  # PATCH/PUT /payslipsettings/1.json
  def update
    respond_to do |format|
      if @payslipsetting.update(payslipsetting_params)
        format.html { redirect_to @payslipsetting, notice: 'Payslipsetting was successfully updated.' }
        format.json { render :show, status: :ok, location: @payslipsetting }
      else
        format.html { render :edit }
        format.json { render json: @payslipsetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payslipsettings/1
  # DELETE /payslipsettings/1.json
  def destroy
    @payslipsetting.destroy
    respond_to do |format|
      format.html { redirect_to payslipsettings_url, notice: 'Payslipsetting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payslipsetting
      @payslipsetting = Payslipsetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payslipsetting_params
      params.require(:payslipsetting).permit(:description, :value, :path, :show, :note)
    end
end
