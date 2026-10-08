class PayProcessedPayrollCsController < ApplicationController
  before_action :set_pay_processed_payroll_c, only: [:show, :edit, :update, :destroy]

  # GET /pay_processed_payroll_cs
  # GET /pay_processed_payroll_cs.json
  def index
    @pay_processed_payroll_cs = PayProcessedPayrollC.all
  end

  # GET /pay_processed_payroll_cs/1
  # GET /pay_processed_payroll_cs/1.json
  def show
  end

  # GET /pay_processed_payroll_cs/new
  def new
    @pay_processed_payroll_c = PayProcessedPayrollC.new
  end

  # GET /pay_processed_payroll_cs/1/edit
  def edit
  end

  # POST /pay_processed_payroll_cs
  # POST /pay_processed_payroll_cs.json
  def create
    @pay_processed_payroll_c = PayProcessedPayrollC.new(pay_processed_payroll_c_params)

    respond_to do |format|
      if @pay_processed_payroll_c.save
        format.html { redirect_to @pay_processed_payroll_c, notice: 'Pay processed payroll c was successfully created.' }
        format.json { render :show, status: :created, location: @pay_processed_payroll_c }
      else
        format.html { render :new }
        format.json { render json: @pay_processed_payroll_c.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_processed_payroll_cs/1
  # PATCH/PUT /pay_processed_payroll_cs/1.json
  def update
    respond_to do |format|
      if @pay_processed_payroll_c.update(pay_processed_payroll_c_params)
        format.html { redirect_to @pay_processed_payroll_c, notice: 'Pay processed payroll c was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_processed_payroll_c }
      else
        format.html { render :edit }
        format.json { render json: @pay_processed_payroll_c.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_processed_payroll_cs/1
  # DELETE /pay_processed_payroll_cs/1.json
  def destroy
    @pay_processed_payroll_c.destroy
    respond_to do |format|
      format.html { redirect_to pay_processed_payroll_cs_url, notice: 'Pay processed payroll c was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_processed_payroll_c
      @pay_processed_payroll_c = PayProcessedPayrollC.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_processed_payroll_c_params
      params.fetch(:pay_processed_payroll_c, {})
    end
end
