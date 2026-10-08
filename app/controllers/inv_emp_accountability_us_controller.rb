class InvEmpAccountabilityUsController < ApplicationController
  before_action :set_inv_emp_accountability_u, only: %i[ show edit update destroy ]

  # GET /inv_emp_accountability_us or /inv_emp_accountability_us.json
  def index
    @inv_emp_accountability_us = InvEmpAccountabilityU.all
  end

  # GET /inv_emp_accountability_us/1 or /inv_emp_accountability_us/1.json
  def show
    #render :layout => false
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'emp_account',
               template: "inv_emp_accountability_us/show.html.erb",
               formats: [:html],
               disposition: :inline,
               orientation:'Portrait',
               page_size:'A4',
                margin: { top: 20, bottom: 20, left: 20, right: 20 },
               footer: { font_size: 5, right: "[page] of [topage] - #{DateTime.now.strftime("%m/%d/%Y %H:%M")}" }
      end
    end
  end

  # GET /inv_emp_accountability_us/new
  def new
    @inv_emp_accountability_u = InvEmpAccountabilityU.new
  end

  # GET /inv_emp_accountability_us/1/edit
  def edit
  end

  # POST /inv_emp_accountability_us or /inv_emp_accountability_us.json
  def create
    @inv_emp_accountability_u = InvEmpAccountabilityU.new(inv_emp_accountability_u_params)

    respond_to do |format|
      if @inv_emp_accountability_u.save
        format.html { redirect_to inv_emp_accountability_u_url(@inv_emp_accountability_u), notice: "Inv emp accountability u was successfully created." }
        format.json { render :show, status: :created, location: @inv_emp_accountability_u }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inv_emp_accountability_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inv_emp_accountability_us/1 or /inv_emp_accountability_us/1.json
  def update
    respond_to do |format|
      if @inv_emp_accountability_u.update(inv_emp_accountability_u_params)
        format.html { redirect_to inv_emp_accountability_u_url(@inv_emp_accountability_u), notice: "Inv emp accountability u was successfully updated." }
        format.json { render :show, status: :ok, location: @inv_emp_accountability_u }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inv_emp_accountability_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inv_emp_accountability_us/1 or /inv_emp_accountability_us/1.json
  def destroy
    @inv_emp_accountability_u.destroy

    respond_to do |format|
      format.html { redirect_to inv_emp_accountability_us_url, notice: "Inv emp accountability u was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def inv_emp_account_show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'OT_Report',
               template: "portal_ot_application_details/ot_report_show.html.erb",
               formats: [:html],
               disposition: :inline,
               orientation:'Landscape',
               footer: { right: "[page] of [topage] - #{DateTime.now.strftime("%m/%d/%Y %H:%M")}" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inv_emp_accountability_u
      @inv_emp_accountability_u = InvEmpAccountabilityU.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inv_emp_accountability_u_params
      params.require(:inv_emp_accountability_u).permit(:CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :EmployeeRefNo, :Remarks, :DeployedBy, :DeploymentDate, :PDFFileName, :ClearBy, :ReturnedDate, :FilingStatusRefNo)
    end
end
