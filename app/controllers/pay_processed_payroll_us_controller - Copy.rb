class PayProcessedPayrollUsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pay_processed_payroll_u, only: [:show, :edit, :update, :destroy]



  # GET /pay_processed_payroll_us
  # GET /pay_processed_payroll_us.json
  def index

      #initialize index
      @payprocessedpayrollus = PayProcessedPayrollU.all
      #checker params
      @x = params[:search]
    
      #get employeerefno in users table
      @emprefno = current_user.EmployeeRefNo
      #get emp client
      @getclientrefno = PisEmploymentInfoU.where(EmployeeRefNo: @emprefno).pluck(:ClientAccountRefNo).to_sentence
      #get emp taxstatus
      @gettaxstatus = PisEmploymentInfoU.where(EmployeeRefNo: @emprefno).pluck(:TaxStatusRefNo).to_sentence
      #get frequency
      @getfrequency = PisEmploymentInfoU.where(EmployeeRefNo: @emprefno).pluck(:PayFrequencyRefNo).to_sentence
      #get basic rate
      @getbasicrate =  PisEmploymentInfoU.where(EmployeeRefNo: @emprefno).pluck(:BasicRate).to_sentence
      #get initial loan when loading index
      @getset = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)
      @test1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
      
      #get if earning exist
      @incometaxexist1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_OtherEarning).to_sentence
      @incometaxexist2 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_FixedEarning).to_sentence
      @getifotherincometaxexist = [@incometaxexist1.to_i, @incometaxexist2.to_i].sum  
      @otherincomenontaxexist1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_OtherNTEarning).to_sentence
      @otherincomenontaxexist2 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_FixedNTEarning).to_sentence
      @getifotherincomenontaxexist = [@otherincomenontaxexist1.to_i, @otherincomenontaxexist2.to_i].sum 
      @totalearnings =  [@getifotherincometaxexist, @getifotherincomenontaxexist].sum  

      #get overtime if exist
      overtimeexist = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:TotalOT).to_sentence
      @getovertimeexist = overtimeexist.to_i
      #get loan details when params is empty
      @getnumberofloans =  PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).count
      #get timesummaryrefno       
      @gettimesumrefno = PayProcessedPayrollU.where(ProcessedPayrollRefNo: @payrollrefid).pluck(:TimeSummaryRefNo).to_sentence
    
            #start get details when seach payroll triggered 
            @pay_processed_payroll_us = if params[:search]
            #checker if params[:seach] has value
            @a = "YES"
            
            #get the id from payrollprocess_u
            getparam1 = params[:search]
            @payrollrefid = getparam1["id"]

            #when search is triggered will check if the confirmed date was empty?
            @getconfirmeddate = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
            if @getconfirmeddate.blank?
            confirmeddate1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)
            confirmeddate1.update(confirmeddate: Time.now)
            @test1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
            else
            @test1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
            end  

            #set pdf path
            if @payrollrefid.blank?
            redirect_to pay_processed_payroll_us_url, :notice => "Please Select Payroll Period!"
            else
            @pdfpath = "/pay_processed_payroll_us/#{@payrollrefid}-#{current_user.EmployeeNumber}.pdf"
            end  



            #get payrolldate format
            date1 = PayProcessedPayrollU.where(ProcessedPayrollRefNo: @payrollrefid).pluck(:PayrollDate).to_sentence
            if date1.empty?
            @payrolldate = date1.to_date  
            else
            @payrolldate = date1.to_date.strftime("%m/%d/%Y")
            end
            
            #get loan details
            @getnumberofloans =  PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).count
            @getsetloan = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)
            @getloanbalsum = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:LoanBalance).sum
            @getloanamtsum = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:LoanDeduction).sum
            
            #get if earning exist
            @incometaxexist1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_OtherEarning).to_sentence
            @incometaxexist2 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_FixedEarning).to_sentence
            @getifotherincometaxexist = [@incometaxexist1.to_i, @incometaxexist2.to_i].sum  
            @otherincomenontaxexist1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_OtherNTEarning).to_sentence
            @otherincomenontaxexist2 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:E_FixedNTEarning).to_sentence
            @getifotherincomenontaxexist = [@otherincomenontaxexist1.to_i, @otherincomenontaxexist2.to_i].sum 
            @totalearnings =  [@getifotherincometaxexist, @getifotherincomenontaxexist].sum  

            #get overtime if exist
            overtimeexist = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:TotalOT).to_sentence
            @getovertimeexist = overtimeexist.to_i
            #get timesummaryrefno       
            @gettimesumrefno = PayProcessedPayrollU.where(ProcessedPayrollRefNo: @payrollrefid).pluck(:TimeSummaryRefNo).to_sentence
            #get cutoff date
            fromdate = TmsTimeSummaryU.where(TimeSummaryRefNo: @gettimesumrefno).pluck(:StartDate).to_sentence
            #this condition checks when TimeSumU was empty
            if fromdate.empty?
            fromdate1 = fromdate.to_date
            else
            fromdate1 = fromdate.to_date.strftime("%m/%d/%Y")
            end 

            todate = TmsTimeSummaryU.where(TimeSummaryRefNo: @gettimesumrefno).pluck(:EndDate).to_sentence
            if todate.empty?
            todate1 = todate.to_date
            else
            todate1 = todate.to_date.strftime("%m/%d/%Y")
            end 
            @cutoffdates = "#{fromdate1} - #{todate1}"


            else
            #if params[:search] has no value
      
            @a = "NO"

      
          end     

  end


  # GET /pay_processed_payroll_us/1
  # GET /pay_processed_payroll_us/1.json
  def show
    @pay_processed_payroll_u = PayProcessedPayrollU.find(params[:id])
    #get employeerefno in users table
    @emprefno = current_user.EmployeeRefNo
    #getloan details
    @getsetloanpdf = PayLoanLedgerU.where(ProcessedPayrollRefNo: 8, EmployeeRefNo: @emprefno)

    #generate pdf section start here
    respond_to do |pdfformat|
            pdfformat.html
            pdfformat.pdf do
              pdf = Pdf.new(@pay_processed_payroll_u,@emprefno,@getsetloanpdf)

              #------------#
              send_data pdf.render, filename: "test.pdf", type: "application/pdf", disposition: "inline"
          end
        end


    #pdf generation ends here

     

  end

  # GET /pay_processed_payroll_us/new
  def new
    @pay_processed_payroll_u = PayProcessedPayrollU.new
  end

  # GET /pay_processed_payroll_us/1/edit
  def edit
  end

  # POST /pay_processed_payroll_us
  # POST /pay_processed_payroll_us.json
  def create
    @pay_processed_payroll_u = PayProcessedPayrollU.new(pay_processed_payroll_u_params)

    respond_to do |format|
      if @pay_processed_payroll_u.save
        format.html { redirect_to @pay_processed_payroll_u, notice: 'Pay processed payroll u was successfully created.' }
        format.json { render :show, status: :created, location: @pay_processed_payroll_u }
      else
        format.html { render :new }
        format.json { render json: @pay_processed_payroll_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_processed_payroll_us/1
  # PATCH/PUT /pay_processed_payroll_us/1.json
  def update
    respond_to do |format|
      if @pay_processed_payroll_u.update(pay_processed_payroll_u_params)
        format.html { redirect_to @pay_processed_payroll_u, notice: 'Pay processed payroll u was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_processed_payroll_u }
      else
        format.html { render :edit }
        format.json { render json: @pay_processed_payroll_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_processed_payroll_us/1
  # DELETE /pay_processed_payroll_us/1.json
  def destroy
    @pay_processed_payroll_u.destroy
    respond_to do |format|
      format.html { redirect_to pay_processed_payroll_us_url, notice: 'Pay processed payroll u was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_processed_payroll_u
      @pay_processed_payroll_u = PayProcessedPayrollU.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_processed_payroll_u_params
      params.require(:pay_processed_payroll_u).permit(:TimeSummaryRefNo, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :MonthRefNo, :PayrollParameterRefNo, :PaymentTermsRefNo, :PayrollDate, :FilingStatusRefNo, :YEAR, :ProcessedPayrollRefNo, :PostedYear, :ServerCompanyCodeID, :search)
   
    end
end

