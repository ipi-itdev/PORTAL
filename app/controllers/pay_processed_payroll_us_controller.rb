class PayProcessedPayrollUsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pay_processed_payroll_u, only: [:show, :edit, :update, :destroy]
  #prepend_before_action :checker_oldpass, only: [:index] # Change this to be any actions you want to protect.
  prepend_before_action :check_update_contact
  prepend_before_action :checkadminloggedin
  prepend_before_action :privacychecker, only: [:index]
  #prepend_before_action :covid_survey_checker
  #prepend_before_action :tempsurvey_checker
  #before_action :checksurvey
  #prepend_before_action :check_ODHD
  #prepend_before_action :media_checker
  #prepend_before_action :check_vacsurvey
  prepend_before_action :log_login
  prepend_before_action :check_expire_password
  prepend_before_action :check_current_user



 
        
  # GET /pay_processed_payroll_us
  # GET /pay_processed_payroll_us.json
  def index

      #initialize index
      #@payprocessedpayrollus = PayProcessedPayrollU.all
      #checker params
      @x = params[:search]

  
      #get employeerefno in users table
      @emprefno = current_user.EmployeeRefNo
      #@emprefno = current_user.EmployeeRefNo

      ##bir2316
      @BIRpath = "#{current_user.AttachmentPath}"
      @getBIRCredentials = ActiveRecord::Base.connection.exec_query("EXEC dbo.PORTAL_SP_BIR2316Credentials @EmpRefNo= #{current_user.EmployeeRefNo}")     
      @BIRlink = "#{@BIRpath}#{@getBIRCredentials.rows[0][0]}"
      ##bir2316

      ##13thmonth
      @get_13thmonth_yr =  ActiveRecord::Base.connection.exec_query("select Value  from TMS_Settings_U tsu where SettingsRefNo = 71 and Code = '13THMONYR'")
      @get_emp_13thmonth  = PayViewReportThirteenthMonthDetail.where(EmployeeRefNo: current_user.EmployeeRefNo, YEAR: @get_13thmonth_yr.rows[0][0])
      ##13thmonth
  

      #get emp client
      ##get employee details
      hashPisEmployeeU = PisEmployeeU.where(EmployeeRefNo: @emprefno).pluck_to_hash(:EmployeeNumber,:Description)
      @PisEmployeeU = hashPisEmployeeU[0]            

      hashPisEmploymentInfoU = PisEmploymentInfoU.where(EmployeeRefNo: @emprefno, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :PayFrequencyRefNo , :BasicRate, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo, :PayrollRateRefNo, :JobPositionRefNo )
      @PayrollRate = PayPayrollRateM.where(PayrollRateRefNo: hashPisEmploymentInfoU[0][:PayrollRateRefNo]).pluck(:Description)
      @PisEmploymentInfoU = hashPisEmploymentInfoU[0]

      if @PisEmploymentInfoU[:EmployeeGroupRefNo] == 1 
        #internal emp
        @getpayrollperiodrecord = PayProcessedPayrollU.find_by_sql("SELECT ID, CONVERT(varchar, PayrollDate, 101) AS PayDate FROM dbo.PAY_ProcessedPayroll_U WHERE  (FilingStatusRefNo = 4) AND (PayrollParameterRefNo = 8) ORDER BY PayrollDate DESC")

        @get_job_position_int = GenJobPositionM.where(JobPositionRefNo: @PisEmploymentInfoU[:JobPositionRefNo] ).pluck(:Description).to_sentence
      else 
        #external emp
        @getpayrollperiodrecord = PayProcessedPayrollU.find_by_sql("SELECT ID, CONVERT(varchar, PayrollDate, 101) AS PayDate FROM dbo.PAY_ProcessedPayroll_U WHERE  (FilingStatusRefNo = 4) AND (PayrollParameterRefNo = 7) ORDER BY PayrollDate DESC")
      end

      
      #@gettaxstatus = GenTaxStatusM.where(TaxStatusRefNo:  @PisEmploymentInfoU[:TaxStatusRefNo] ).pluck(:Description).to_sentence
      @getfrequency = GenFrequencyM.where(FrequencyRefNo: @PisEmploymentInfoU[:PayFrequencyRefNo]).pluck(:Description).to_sentence
      ##end employee details

      @getset = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)
      #@test1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
      
          #start get details when seach payroll triggered 
            if params[:search]

            #checker if params[:seach] has value
            @a = "YES"

             getpaypararefno = PisEmploymentInfoU.where(EmployeeRefNo: @emprefno, IsActive: 1).pluck(:PayrollParameterRefNo).to_sentence

            converttodate1 = params[:search]
            converttodate = converttodate1[:PayDate]


             getparam1 = PayProcessedPayrollU.find_by_sql("Select * from  PAY_ProcessedPayroll_U where PayrollDate = CAST('#{converttodate}'AS datetime) and PayrollParameterRefNo = #{getpaypararefno} and FilingStatusRefNo = 4").pluck(:ProcessedPayrollRefNo).to_sentence
            
            ##get the process payroll refno from payrollprocess_u
            @payrollrefid = getparam1

            #when search is triggered will check if the confirmed date was empty?
            @getconfirmeddate = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
            if @getconfirmeddate.blank?
            confirmeddate1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)
            confirmeddate1.update(confirmeddate: Time.now)
            #@test1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
            else
            #@test1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
            end  

            ##get basicpay
             @hashBasicPay = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck_to_hash(:BasicPay, :E_EcolaRate, :BasicRate)
            ## end basicpay

            #get payrolldate format
            date1 = PayProcessedPayrollU.where(ProcessedPayrollRefNo: @payrollrefid).pluck(:PayrollDate).to_sentence
            if date1.empty?
              @payrolldate = date1.to_date  
            else
              @payrolldate = date1.to_date.strftime("%m/%d/%Y")
            end

            ##get timesummaryrefno       
            @gettimesumrefno = PayProcessedPayrollU.where(ProcessedPayrollRefNo: @payrollrefid).pluck(:TimeSummaryRefNo).to_sentence
            ##get cutoff date
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


            #get loan details
            @getnumberofloans =  PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).count
            @getsetloan = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)
            @getloanbalsum = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:LoanBalance).sum
            @getloanamtsum = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck(:LoanDeduction).sum

            ##get basicpay exist
            @getemppay = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno ).pluck(:BasicPay).to_sentence
            ## end get basicpay exist


            ##get if earning exist
            hashEarningexist = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck_to_hash(:E_OtherEarning ,:E_FixedEarning, :E_OtherNTEarning, :E_FixedNTEarning )
            if hashEarningexist.blank?
               #empty
            else
               @getifotherincometaxexist = [hashEarningexist[0][:E_OtherEarning].to_f, hashEarningexist[0][:E_FixedEarning].to_f].sum
               @getifotherincomenontaxexist = [hashEarningexist[0][:E_OtherNTEarning].to_f, hashEarningexist[0][:E_FixedNTEarning].to_f].sum
               @totalearnings =  [@getifotherincometaxexist, @getifotherincomenontaxexist].sum  
            end
            ##end earning exist

            ##get overtime if exist
            @getOTs = ViewConvertEmployeeOvertimePayslip.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)
            hashOTPayProcessedPayrollC = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck_to_hash(:TotalOT, :TotalRD, :TotalHOL, :ND , :NDOT, :OT)
            
            if hashOTPayProcessedPayrollC.blank?
              
            else
              @getovertimeexist = [hashOTPayProcessedPayrollC[0][:OT].to_f,hashOTPayProcessedPayrollC[0][:TotalRD].to_f, hashOTPayProcessedPayrollC[0][:TotalHOL].to_f, hashOTPayProcessedPayrollC[0][:ND].to_f, hashOTPayProcessedPayrollC[0][:NDOT].to_f].sum
            end

            ##end overitme


            ##start deduction
            hashDeductTmsTimeSummaryHdrC = TmsTimeSummaryHdrC.where(TimeSummaryRefNo: @gettimesumrefno, EmployeeRefNo: @emprefno).pluck_to_hash(:AH, :LH, :UT, :LWOP)
            @DeductTmsTimeSummaryHdrC = hashDeductTmsTimeSummaryHdrC[0] 
            hashDeductPayProcessedPayrollC =  PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck_to_hash(:AH, :LH, :UT, :LWOP, :SSS_EE, :PhilHealth_EE, :Pagibig_EE, :WithHoldingTax, :D_Total_OtherDeduction )
            @DeductPayProcessedPayrollC = hashDeductPayProcessedPayrollC[0]
            ##end deduction


            ##get otherdeduction breakdown
            
            @getotherdeductiontotals = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck_to_hash(:D_Total_OtherDeduction, :D_Total_FixedDeduction)
            # = [getotherdeductiontotals1[0][:D_Total_OtherDeduction].to_f,getotherdeductiontotals1[0][:Total_FixedDeduction].to_f].sum
            @getotherdeductiontaxable = ViewEmployeePayItemHistory.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno, IsDeduction: 1, IsTaxable: 1 )
            @getotherdeductionnontaxable = ViewEmployeePayItemHistory.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno, IsDeduction: 1, IsTaxable: 0 )
            ##end get other deduction breakdown


            ##grand total
            hashGrandPayProcessedPayrollC = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno).pluck_to_hash(:GrossPay, :TotalDeductions, :TaxableIncome, :NetPay, :GrossNetPay)
            @GrandTotals = hashGrandPayProcessedPayrollC[0]
            ##end grand total


              #set pdf path
              if @payrollrefid.blank?
                redirect_to pay_processed_payroll_us_url, :notice => "Please Select Payroll Period!"
              else
                getidforpdf  =  PayProcessedPayrollU.where(ProcessedPayrollRefNo: @payrollrefid).pluck(:id).to_sentence
                @pdfpath = "/pay_processed_payroll_us/#{getidforpdf}-#{current_user.EmployeeNumber}.pdf"
              end

            #start record datetime payslip generate
            userdatepayslipgen = User.find_by(EmployeeRefNo: @emprefno)
            userdatepayslipgen.update(datepayslipgen: Time.now) 
            #end record datetime payslip generate 


            else
            #if params[:search] has no value
      
            @a = "NO"

      
          end     

  end


  # GET /pay_processed_payroll_us/1
  # GET /pay_processed_payroll_us/1.json
  
  def show
    @pay_processed_payroll_u = PayProcessedPayrollU.find(params[:id].to_i)
    @pay_processed_payroll_u_refno = PayProcessedPayrollU.where(ProcessedPayrollRefNo: @payrollrefid)
    #get employeerefno in users table
    @emprefno = current_user.EmployeeRefNo
    
    #getloan details
    @getsetloanpdf = PayLoanLedgerU.where(ProcessedPayrollRefNo: @payrollrefid, EmployeeRefNo: @emprefno)

    #generate pdf section start here
    respond_to do |pdfformat|
            pdfformat.html
            pdfformat.pdf do
              pdf = GenPdf.new(@pay_processed_payroll_u,@emprefno,@getsetloanpdf, @pay_processed_payroll_u_refno)

              send_data pdf.render, filename: "payslip.pdf", type: "application/pdf", disposition: "inline"
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

    private
    def checker_oldpass

      if current_user.blank?

      flash[:success] = "Welcome to the Sample App!"  

      else

        xcur = current_user.id
        ycur = User.where(id: xcur).pluck(:encrypted_password).to_sentence
        ycur1 = ycur.to_s
        zcur = "$2a$11$txIf0M5feHeEkP4KGPkdf.5RCka0DHycG.bav3oKhlhzgEj.LTeFW"

      if ycur1.to_s ==  zcur.to_s
        redirect_to '/users/password/new' and return
      else
        flash[:success] = "Welcome to the Sample App!"  
      end
    end
    end

    private
    def checkadminloggedin

      if user_signed_in? == false
        @getuserrefno110 = 0
      else
        getuserrefno110 = current_user.EmployeeRefNo
        getuserrefnoforbday = getuserrefno110
        @getuserrefno110 = User.where(EmployeeRefNo:getuserrefno110).pluck(:IsAdmin).to_sentence

      end 

    end


    ##start privacychecker
    private
    def privacychecker
      if user_signed_in? == false
      else
        isagreedprivacy = current_user.IsAgreedPrivacy
        if isagreedprivacy == true
        else
          redirect_to '/privacies/new'
        end
      end 
    end
    ##end privacychecker

    private
    def checksurvey

      if user_signed_in? == false

        redirect_to '/sign_in' and return

      else
        porsurveychecker = PorSurvey.exists?(EmployeeRefNo: current_user.EmployeeRefNo)

        if porsurveychecker == true
          
        else
          redirect_to '/por_surveys/new' and return
        end
        
      end

    end

  ##temp survey
  private
  def tempsurvey_checker
    if PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? == false
      redirect_to hrc_effectiveness_survey_path and return
    end
  end
  ##temp survey


    #start check covid survey
    private
    def covid_survey_checker

      get_emp_group = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck(:EmployeeGroupRefNo).to_sentence

      if get_emp_group == '1' #for internal
        #flash[:notice] = "internal#{get_emp_group}"
      else #for external
        #flash[:notice] = "external#{get_emp_group}"
        check_covid_survey_exist = PortalSurveyCovid19.where(employeerefno: current_user.EmployeeRefNo).exists?

        if check_covid_survey_exist == true
          #nothing to do
        else ##false
          redirect_to new_portal_survey_covid19_path
        end

      end
          
    end
    #end check covid survey


    #start check_ODHD
    private
    def check_ODHD

          if current_user.DoneDHS == true
            #nothing
            #flash[:notice] = "#{current_user.DoneDHS}"
          else
            redirect_to '/ODHD'
          end

    end
    #end check_ODHD


    ## start media checker
    def media_checker
      #get the last media refno
      get_user_info = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck_to_hash(:EmployeeRefNo, :last_media_refno)


       if get_user_info[0][:last_media_refno] == 0

        #flash[:notice] = "blank"
        count_unfinished_media = ViewEmployeeMediaDetail.where(EmployeeRefNo:get_user_info[0][:EmployeeRefNo], endtime: nil).where.not(starttime: nil).first

        if count_unfinished_media.blank?

          count_new_media = ViewEmployeeMediaDetail.where(EmployeeRefNo: get_user_info[0][:EmployeeRefNo] , starttime: nil).count

          if count_new_media.blank?
            ## nothing to do
            #no new media   
            #flash[:notice] = " no new media for user"
            #redirect_to new_por_empmediadetail_path

          else
            #nothing to do
            #flash[:notice] = "redirect to - #{count_new_media}"
            redirect_to new_por_empmediadetail_path
          end

        else
          #direct to unfinished media
          #flash[:notice] = " great new media x true - / #{count_unfinished_media.id}"
          redirect_to edit_por_empmediadetail_path(id: count_unfinished_media.id)
        end

      
       else # if last_media != 0

        #start loop
        ViewEmployeeMediaDetail.where(EmployeeRefNo: get_user_info[0][:EmployeeRefNo]).each do |empmediadetails|

          if  empmediadetails.media_seq_refno <= get_user_info[0][:last_media_refno] 
            #nothing to do skip
            #flash[:notice] = " lesshant equal new media x true - #{get_user_info[0][:last_media_refno]}"

          else

            #flash[:notice] = " great new media x true - #{get_user_info[0][:last_media_refno]} / #{empmediadetails.media_seq_refno}"

            ##start checking unfinish
          get_unfinished_media = ViewEmployeeMediaDetail.where(EmployeeRefNo:get_user_info[0][:EmployeeRefNo], endtime: nil).where.not(starttime: nil).first

            if get_unfinished_media.blank?

              #flash[:notice] = " xxxx - #{get_unfinished_media}"
              redirect_to new_por_empmediadetail_path(:blank => "y") and return 

            else
              #direct to unfinished media
              #flash[:notice] = " xxxx unfinished- #{get_unfinished_media}"
              redirect_to edit_por_empmediadetail_path(id: get_unfinished_media.id) and return
            end
            ##end checking unfinish


          end

        end
        #end loop

       end

    end 
    ## end media checker
    

    ##start check vacsurvey
    def check_vacsurvey

       get_vacsuvey_exist =  PortalVacsurveyU.where(EmployeeRefNo:current_user.EmployeeRefNo).exists?

       if get_vacsuvey_exist == true
          #nothing to do
       else
          redirect_to '/portal_vacsurvey_us/new'
       end
      
    end
    ##end check vacsurvey


    #start check_expire_password
    def check_expire_password
      dayexpire = ActiveRecord::Base.connection.exec_query("SELECT dbo.TMS_FN_GetSettingsValue(#{current_user.EmployeeRefNo},57,'1-1')").rows[0][0].to_s
      datechanged_datetime_plus_3mons = current_user.PasswordCreatedDate + dayexpire.to_i.days

      get_utc = ActiveRecord::Base.connection.exec_query("SELECT DATEADD(HOUR,8,GETUTCDATE())")

      if get_utc.rows[0][0] >= datechanged_datetime_plus_3mons
        redirect_to user_expire_password_path
      end
    end
    #end check_expire_password

    def log_login
      portal_login  = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, IPAddress: request.remote_ip, Module: request.url  )
      portal_login.save    
    end

    def check_current_user
      if user_signed_in? == false
        flash[:notice] = 'Session ended, Please try to login.'
        redirect_to '/'
      end    
    end

      
    private
    def check_update_contact
      if current_user.UpdatedContactInfo == false
        session[:contactedit] = 1
        ActiveRecord::Base.connection.execute("EXEC dbo.PIS_SP_PopulateUpdateContactInPortal @EmployeeRefNo = #{current_user.EmployeeRefNo}")

        redirect_to edit_portal_contact_path(id: current_user.EmployeeRefNo)
      end
    end



end

