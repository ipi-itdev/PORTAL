class GenPdf < Prawn::Document

def initialize(pay_processed_payroll_u,emprefno, getsetloanpdf, pay_processed_payroll_u_refno)
    super(top_margin:10,left_margin: 10, right_margin: 10)

    #initialize amounts
    @pay_processed_payroll_u = pay_processed_payroll_u

    pdfgetpayrefno = PayProcessedPayrollU.where(ID: @pay_processed_payroll_u).pluck(:ProcessedPayrollRefNo).to_sentence

    @emprefno = emprefno
    @getsetloanpdf = getsetloanpdf
    @pay_processed_payroll_u_refno = pdfgetpayrefno

    ##emp details
    pdfempdetails = PisEmploymentInfoU.where(EmployeeRefNo: @emprefno, IsActive: 1).pluck_to_hash(:EmployeeNumber, :PayFrequencyRefNo, :BasicRate, :TaxStatusRefNo)
    hashpdfPisEmployeeU = PisEmployeeU.where(EmployeeRefNo: @emprefno).pluck_to_hash(:Description, :FullName)

    #get frequency
    pdfgetfrequency = GenFrequencyM.where(FrequencyRefNo: pdfempdetails[0][:PayFrequencyRefNo]).pluck(:Description).to_sentence

    #get basic rate
	pdfgetbasicrate = pdfempdetails[0][:BasicRate].to_s(:currency).gsub("$",'')

	#get tax status
	pdfgettaxstatus = GenTaxStatusM.where(TaxStatusRefNo: pdfempdetails[0][:TaxStatusRefNo] ).pluck(:Description).to_sentence
    ##end emp details

    ## get from  PayProcessedPayrollC
    hashPdfPayProcessedPayrollC = PayProcessedPayrollC.where(ProcessedPayrollRefNo:  @pay_processed_payroll_u.ProcessedPayrollRefNo , EmployeeRefNo: @emprefno).pluck_to_hash(:BasicPay, :E_EcolaRate, :E_SEA, :AH, :LH, :UT, :LWOP, :SSS_EE, :PhilHealth_EE, :Pagibig_EE, :WithHoldingTax, :GrossPay, :TotalDeductions, :NetPay, :TaxableIncome, :BasicRate, :GrossNetPay)
	pdfgetTOTALGROSS = hashPdfPayProcessedPayrollC[0][:GrossNetPay].to_s(:currency).gsub("$",'')
	pdfgetTOTALDEDUC = hashPdfPayProcessedPayrollC[0][:TotalDeductions].to_s(:currency).gsub("$",'')
	pdfgetTOTALNET = hashPdfPayProcessedPayrollC[0][:NetPay].to_s(:currency).gsub("$",'')
	pdfgetTOTALTAX = hashPdfPayProcessedPayrollC[0][:TaxableIncome].to_s(:currency).gsub("$",'')
	pdfbasicratefinal = hashPdfPayProcessedPayrollC[0][:BasicRate].to_s(:currency).gsub("$",'')
    ## end get from PayProcessedPayrollC

    ## get TmsTimeSummaryHdrC
    hashPdfTmsTimeSummaryHdrC = TmsTimeSummaryHdrC.where(TimeSummaryRefNo: @pay_processed_payroll_u.TimeSummaryRefNo, EmployeeRefNo: @emprefno).pluck_to_hash(:AH, :LH, :UT, :LWOP)
    ## end get TmsTimeSummaryHdrC

	##get cutoff dates
	hashpdfTmsTimeSummaryU = TmsTimeSummaryU.where(TimeSummaryRefNo: @pay_processed_payroll_u.TimeSummaryRefNo).pluck_to_hash(:StartDate, :EndDate)
	
	#this condition checks when TimeSumU was empty
	if hashpdfTmsTimeSummaryU[0][:StartDate].blank?
		pdffromdate1 = hashpdfTmsTimeSummaryU[0][:StartDate].to_date
	else
		pdffromdate1 = hashpdfTmsTimeSummaryU[0][:StartDate].to_date.strftime("%m/%d/%Y")
	end

	
	if hashpdfTmsTimeSummaryU[0][:EndDate].blank?
		pdftodate1 = hashpdfTmsTimeSummaryU[0][:EndDate].to_date
	else
		pdftodate1 = hashpdfTmsTimeSummaryU[0][:EndDate].to_date.strftime("%m/%d/%Y")
	end 
	pdfcutoffdates = "#{pdffromdate1} - #{pdftodate1}"
    ##end of get cutoff dates


    ##get payrolldate format
	pdfpaydate = PayProcessedPayrollU.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo).pluck(:PayrollDate).to_sentence
	if pdfpaydate.empty?
		pdfpayrolldate = pdfpaydate.to_date  
	else
		pdfpayrolldate = pdfpaydate.to_date.strftime("%m/%d/%Y")
	end
	## end get payrolldate format

	
	#get loans
	#getloanbalsum = PayLoanLedgerU.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck(:LoanBalance).sum
	getloanamtsum2 = PayLoanLedgerU.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck(:LoanDeduction).sum
    getloanamtsum1 = getloanamtsum2.to_f
	getloanamtsum = getloanamtsum1.to_s(:currency).gsub("$",'')
    getnumberofloans =  PayLoanLedgerU.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).count

    #get confirmed date
    pdfgetconfirmeddate1 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck(:confirmeddate).to_sentence
    if pdfgetconfirmeddate1.empty?
		pdfgetconfirmeddate = pdfgetconfirmeddate1.to_date
	else
		pdfgetconfirmeddate = pdfgetconfirmeddate1.to_date.strftime("%m/%d/%Y")
	end 

	##get other earnings
	hashpdfincometaxexist = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck_to_hash(:E_OtherEarning, :E_FixedEarning)
	pdfgetifotherincometaxexist = [hashpdfincometaxexist[0][:E_OtherEarning].to_f, hashpdfincometaxexist[0][:E_FixedEarning].to_f].sum
	hashpdfotherincomenontaxexist = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck_to_hash(:E_OtherNTEarning, :E_FixedNTEarning )
	pdfgetifotherincomenontaxexist = [hashpdfotherincomenontaxexist[0][:E_OtherNTEarning].to_f, hashpdfotherincomenontaxexist[0][:E_FixedNTEarning].to_f].sum 
    pdftotalearnings =  [pdfgetifotherincometaxexist, pdfgetifotherincomenontaxexist].sum
    ## end get other earnings


    ##get other income tax
    pdfgetotherincometax111 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck_to_hash(:E_OtherEarning, :E_FixedEarning)
	pdfgetotherincometaxsum1 =  [pdfgetotherincometax111[0][:E_OtherEarning].to_f,pdfgetotherincometax111[0][:E_FixedEarning].to_f].sum
    pdfgetotherincometaxsum = pdfgetotherincometaxsum1.to_s(:currency).gsub("$",'')
    ##get other income tax

    ##get other income non tax
    pdfgetotherincomenontax111 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck_to_hash(:E_FixedNTEarning, :E_OtherNTEarning)
	pdfgetotherincomenontaxsum1 =  [pdfgetotherincomenontax111[0][:E_FixedNTEarning].to_f,pdfgetotherincomenontax111[0][:E_OtherNTEarning].to_f].sum
	pdfgetotherincomenontaxsum = pdfgetotherincomenontaxsum1.to_s(:currency).gsub("$",'')
	##end get other income non tax

	##get ots
	pdfotexist = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck_to_hash(:TotalOT, :TotalRD, :TotalHOL, :ND, :NDOT, :OT)
	pdfgetovertimeexist = [pdfotexist[0][:OT].to_f,pdfotexist[0][:TotalRD].to_f,pdfotexist[0][:TotalHOL].to_f,pdfotexist[0][:ND].to_f,pdfotexist[0][:NDOT].to_f].sum
	pdfgetovertimesum = pdfgetovertimeexist.to_s(:currency).gsub("$",'')
	##end ots


	##get other deductions
	pdfgetotherdeductiontotals2 = PayProcessedPayrollC.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck_to_hash(:D_Total_OtherDeduction, :D_Total_FixedDeduction )
	pdfgetotherdeductiontotals1 = [pdfgetotherdeductiontotals2[0][:D_Total_OtherDeduction].to_f, pdfgetotherdeductiontotals2[0][:D_Total_FixedDeduction].to_f].sum
	pdfgetotherdeductiontotals =  pdfgetotherdeductiontotals1.to_s(:currency).gsub("$",'')
	##end get other deductions

	getdategenerated = Time.now

  	#========design start here

  	 create_stamp("stampx") do
		  #fill_color "D3D3D3"
		  image "#{Rails.root}/app/assets/images/pdfback.png",
		  	:position => 0,
		    :width  => 595,
		    :height =>330,
		    #:align  => :center,
		    :valign => 10
		    #:at     => [0, bounds.height],
		    #:rotate => 35,
		    #:rotate_around => :center
		end
		stamp("stampx")



		 create_stamp("stamp") do
		  fill_color "808080"
		  text_box "Confidential",
		  	:position => 500,
		    :size   => 60,
		    :width  => bounds.width,
		    :height => bounds.height,
		    #:align  => :center,
		    :valign => 100,
		    #:at     => [0, bounds.height],
		    :rotate => 30,
		    :rotate_around => :center
		end
		#stamp("stamp")
		stamp_at "stamp", [120, -50]


  	#box upper
	bounding_box([0, 750], :width => 595, :height => 65) do
 	transparent(1) { stroke_bounds }
	end
	#box title
	bounding_box([45, 735], :width => 540, :height => 65) do
	text "Information Professionals, Inc.",:size => 12,:style =>:bold	
 	transparent(0) { stroke_bounds }
	end
	#box emp name - number
	bounding_box([45, 715], :width => 540, :height => 65) do
	text "Employee: #{pdfempdetails[0][:EmployeeNumber]} - #{hashpdfPisEmployeeU[0][:Description]}",:size => 11, :style =>:bold	
 	transparent(0) { stroke_bounds }
	end

	#big box lower
	bounding_box([0,685 ], :width => 595, :height => 270) do
	#EMPTY
 	transparent(2) { stroke_bounds }
	end

	#box left emp payslip title
	bounding_box([440, 715], :width => 540, :height => 65) do
	%w[u].each do |tag|
 	text "<#{tag}>EMPLOYEE PAYSLIP</#{tag}> ", :size => 12,:inline_format => true, :style =>:bold
	end	
 	transparent(0) { stroke_bounds }
 	end

 	#lower box 1 DESCRIPTIONS
	bounding_box([0,685 ], :width => 197, :height => 210) do
	move_down 10
	%w[u].each do |tag|
 	text "<#{tag}>Earnings</#{tag}> ", :size => 10,:inline_format => true, :style =>:bold, :indent_paragraphs => 5
	end
	move_down 5
	text"Basic Pay:", :size => 9, :indent_paragraphs => 10
	move_down 5
	text"ECOLA:", :size => 9 , :indent_paragraphs => 10
	move_down 5
	move_down 5
	text"",:size => 9 , :indent_paragraphs => 10
	move_down 5
	%w[u].each do |tag|
 	text "<#{tag}>Deductions</#{tag}> ", :size => 10,:inline_format => true, :style =>:bold, :indent_paragraphs => 5
	end
	move_down 5
	text"Absences:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"Late/Tardiness:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"Undertime:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"LWOP:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"SSS Contribution:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"PhilHealth Contribution:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"Pag-IBIG Contribution:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"Withholding Tax:",:size => 9, :indent_paragraphs => 10
 	transparent(2) { stroke_bounds }
	end
	#end box 1

	#box 1 amounts OF EARNING/DEDUCTIONS
	bounding_box([127,685 ], :width => 65, :height => 210) do
	move_down 27
	text"#{hashPdfPayProcessedPayrollC[0][:BasicPay].to_s(:currency).gsub("$",'')}", :size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:E_EcolaRate].to_s(:currency).gsub("$",'')}", :size => 9 , :indent_paragraphs => 10 , :align => :right
	move_down 5
	#text"#{hashPdfPayProcessedPayrollC[0][:E_SEA].to_s(:currency).gsub("$",'')}",:size => 9 , :indent_paragraphs => 10, :align => :right
	move_down 26
	text"#{hashPdfPayProcessedPayrollC[0][:AH].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:LH].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:UT].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:LWOP].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:SSS_EE].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:PhilHealth_EE].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:Pagibig_EE].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{hashPdfPayProcessedPayrollC[0][:WithHoldingTax].to_s(:currency).gsub("$",'')}",:size => 9, :indent_paragraphs => 10, :align => :right
 	transparent(0.0) { stroke_bounds }
	end
	#end box 1 amounts


	#box 1 hours OF DEDUCTIONS
	bounding_box([65,617 ], :width => 65, :height => 100) do
	text"HOURS", :size => 8, :indent_paragraphs => 10, :align => :right
	move_down 7
	text"#{"%0.2f" %hashPdfTmsTimeSummaryHdrC[0][:AH]}", :size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{"%0.2f" %hashPdfTmsTimeSummaryHdrC[0][:LH]}", :size => 9 , :indent_paragraphs => 10 , :align => :right
	move_down 5
	text"#{"%0.2f" %hashPdfTmsTimeSummaryHdrC[0][:UT]}",:size => 9 , :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{"%0.2f" %hashPdfTmsTimeSummaryHdrC[0][:LWOP]}",:size => 9 , :indent_paragraphs => 10, :align => :right
 	transparent(0.0) { stroke_bounds }
	end
	#end box 1 hours


	#lower box 2 / LOAN DETAILS
	bounding_box([197,685], :width => 201, :height => 210) do
	#move_down 10
	#%w[u].each do |tag|
 	#text "<#{tag}>Loan Details </#{tag}> ", :size => 10,:inline_format => true, :style =>:bold, :indent_paragraphs => 5
	#end

 	transparent(2) { stroke_bounds }
	end
	#end box 2

	#lower box 3
	bounding_box([398,685 ], :width => 197, :height => 85) do
	move_down 10
	text" Payroll Date:" ,:size => 9, :indent_paragraphs => 10
	move_down 5
	text"Cut-off Date:" ,:size => 9, :indent_paragraphs => 10
	move_down 5
	text"Payroll Frequency:",:size => 9, :indent_paragraphs => 10
	move_down 5
	text"Basic Rate:" ,:size => 9, :indent_paragraphs => 10
	move_down 5
	text"" ,:size => 9, :indent_paragraphs => 10
 	transparent(1) { stroke_bounds }
	end
	#end box 3


	#lower box 3 amounts
	bounding_box([410,685 ], :width => 180, :height => 85) do
	move_down 10
	text" #{pdfpayrolldate}" ,:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{pdfcutoffdates}" ,:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{pdfgetfrequency}",:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{pdfbasicratefinal}" ,:size => 9, :indent_paragraphs => 10, :align => :right
	move_down 5
	text"#{}" ,:size => 9, :indent_paragraphs => 10, :align => :right
 	transparent(0) { stroke_bounds }
	end
	#end box 3 amounts


	#lower box 4
	bounding_box([398,600 ], :width => 197, :height => 80	) do
	move_down 10
	text" GROSS PAY:" ,:size => 9, :indent_paragraphs => 10, :style =>:bold
	move_down 15
	text"DEDUCTIONS:" ,:size => 9, :indent_paragraphs => 10, :style =>:bold
	move_down 15
	text"NET PAY:" ,:size => 9, :indent_paragraphs => 10, :style =>:bold

 	transparent(1) { stroke_bounds }
	end
	#end box 4


	#lower box 4 amounts
	bounding_box([410,600 ], :width => 180, :height => 80	) do
	move_down 10
	text" #{pdfgetTOTALGROSS}" ,:size => 9, :indent_paragraphs => 10 , :align => :right
	move_down 15
	text"#{pdfgetTOTALDEDUC}" ,:size => 9, :indent_paragraphs => 10 , :align => :right
	move_down 15
	text"#{pdfgetTOTALNET}" ,:size => 12, :indent_paragraphs => 10 , :align => :right, :style =>:bold

 	transparent(0) { stroke_bounds }
	end
	#end box 4 amounts


	#lower box 5
	bounding_box([0,475 ], :width => 398, :height => 60	) do
	#EMPTY
	transparent(1) { stroke_bounds }
	end
	#end box 5
	

	#lower box 6
	bounding_box([0,475 ], :width => 197, :height => 60	) do
	move_down 15
	text"GROSS PAY:" ,:size => 9, :indent_paragraphs => 5, :style =>:bold
	move_down 15
	text"DEDUCTIONS:" ,:size => 9, :indent_paragraphs => 5, :style =>:bold
	transparent(0) { stroke_bounds }
	end
	#end box 6

	#lower box 6 amounts
	bounding_box([92,475 ], :width => 100, :height => 60	) do
	move_down 15
	text"#{pdfgetTOTALGROSS}" ,:size => 9, :indent_paragraphs => 5, :style =>:bold,:align => :right
	move_down 15
	text"#{pdfgetTOTALDEDUC}" ,:size => 9, :indent_paragraphs => 5, :style =>:bold,:align => :right
	transparent(0.0) { stroke_bounds }
	end
	#end box 6 amounts

	
	#lower box 7 
	bounding_box([197,475 ], :width => 201, :height => 60	) do
	move_down 15
	text"TAXABLE INCOME:" ,:size => 9, :indent_paragraphs => 5, :style =>:bold
	move_down 15
	text"NET PAY:" ,:size => 9, :indent_paragraphs => 5, :style =>:bold

	transparent(0) { stroke_bounds }
	end
	#end box 7

	#lower box 7 amount
	bounding_box([294,475 ], :width => 100, :height => 60	) do
	move_down 15
	text"#{pdfgetTOTALTAX}" ,:size => 9, :indent_paragraphs => 5, :style =>:bold,:align => :right
	move_down 15
	text"#{pdfgetTOTALNET}" ,:size => 9, :indent_paragraphs => 5, :style =>:bold,:align => :right

	transparent(0.0) { stroke_bounds }
	end
	#end box 7 amount

	#lower box 8
	bounding_box([398,520 ], :width => 197, :height => 105	) do
	move_down 10
	text"I acknowledge to have received the amount" ,:size => 9, :indent_paragraphs => 10
	move_down 10
	text"stated and have no further claims for services" ,:size => 9, :indent_paragraphs => 10
	move_down 20
	text"Payment Received by:" ,:size => 9, :indent_paragraphs => 10
	move_down 15
	%w[u].each do |tag|
 	text "<#{tag}>#{hashpdfPisEmployeeU[0][:FullName]}</#{tag}> ", :size => 8,:inline_format => true,  :indent_paragraphs => 10
	end
	transparent(0.5) { stroke_bounds }
	end
	#end box 8


	#lower box 9
	bounding_box([520,460 ], :width => 197, :height => 105	) do
	text"Date:" ,:size => 9
	move_down 15
	text"_____________" ,:size => 9, :style =>:bold
	transparent(0) { stroke_bounds }
	end 
	#end box 9


	#lower box 10
	bounding_box([515,435 ], :width => 197, :height => 105	) do
	text"#{pdfgetconfirmeddate}" ,:size => 9,  :indent_paragraphs => 15
	move_down 25
	text "Date Generated:" ,:size => 6
	move_down 2
	text"#{getdategenerated}" ,:size => 6
	transparent(0) { stroke_bounds }
	end 
	#end box 10

		
	#box FOR TABLE LEAVES / OTHER EARNINGS / OTS
	
	bounding_box([201,665 ], :width => 201, :height => 300	) do
	
		if getnumberofloans <= 0
			text""
		else
			%w[u].each do |tag|
 			text "<#{tag}>Loan Details</#{tag}> ", :size => 8,:inline_format => true, :style =>:bold
			end	

			data1 = [["","Amount", "Balance"]]			
			data2 = LoanDetail.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck(:Description, :LoanDeduction,:LoanBalance)
			data3 = [["","Total:","#{getloanamtsum}",""]]

			table(data1,:cell_style => { size: 7 },:column_widths => [70, 60, 60]) do
			columns(1..2).style(:align => :right)
			row(0..2).font_style = :bold
			cells.borders = []
			cells.padding = 1
			end

			table(data2,:cell_style => { size: 7 },:column_widths => [70, 60, 60]) do
			columns(1..2).style(:align => :right)
			cells.borders = []
			cells.padding = 1
			end

			table(data3,:cell_style => { size: 7 },:column_widths => [10, 60, 60, 60]) do
			columns(0..3).style(:align => :right)		
			row(0..3).font_style = :bold
			cells.padding = 1
			cells.borders = []
			end

			move_down 5

			#%w[u].each do |tag|
	 		#text"<#{tag}>Pay Item</#{tag}>", :size => 10,:inline_format => true, :style =>:bold
			#end
		end
		

		if pdftotalearnings <= 0
			text""
		else
			%w[u].each do |tag|
 			text "<#{tag}>Other Earnings</#{tag}> ", :size => 7,:inline_format => true, :style =>:bold
			end	

				if pdfgetifotherincometaxexist <= 0
					text""
				else
					text"Taxable", size: 7, :style =>:bold
					#data1 = [["",""]]			
					data2 = ViewEmployeePayItemHistory.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno, IsTaxable: 1, IsDeduction: 0 ).pluck(:PayItem, :PAYITEMAMOUNT)
					#data2 = [["Other Income (Taxable):","#{pdfgetotherincometaxsum}"]]
					data3 = [["","","Total:","#{pdfgetotherincometaxsum}"]]		
					#table(data1,:cell_style => { size: 9 },:column_widths => [70, 120]) do
					#columns(1..2).style(:align => :right)
					#row(0..2).font_style = :bold
					#cells.borders = []
					#cells.padding = 1
					#end

					table(data2,:cell_style => { size: 7 },:column_widths => [120,70]) do
					columns(1..3).style(:align => :right)
					#row(0..2).font_style = :bold
					cells.borders = []
					cells.padding = 1
					end

					table(data3,:cell_style => { size: 7 },:column_widths => [70,20,40,60]) do
					columns(1..3).style(:align => :right)
					row(0..3).font_style = :bold
					cells.borders = []
					cells.padding = 1
					end
					 
				end	

				move_down 5

				if pdfgetifotherincomenontaxexist <= 0
					text""
				else
					text"Non-Taxable", size: 7, :style =>:bold
					#data1 = [["",""]]			
					data2 = ViewEmployeePayItemHistory.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno, IsTaxable: 0, IsDeduction: 0 ).pluck(:PayItem, :PAYITEMAMOUNT)
					#data2 = [["Other Income (Non-Taxable):","#{pdfgetotherincomenontaxsum}"]]	
					data3 = [["","","Total:","#{pdfgetotherincomenontaxsum}"]]		
				
					table(data2,:cell_style => { size: 7 },:column_widths => [120, 70]) do
					columns(1..3).style(:align => :right)
					cells.borders = []
					cells.padding = 1
					end

					table(data3,:cell_style => { size: 7 },:column_widths => [70,20,40,60]) do
					columns(1..3).style(:align => :right)
					row(0..3).font_style = :bold
					cells.borders = []
					cells.padding = 1
					end


				end
		end				

		move_down 5
		

				if pdfgetovertimeexist <= 0
					text""
				else
					data1 = [["Overtime","Rate","Hrs.", "Amount"]]			
					data2 = ViewConvertEmployeeOvertimePayslip.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno).pluck(:OTCode, :Rate,:Hours,:OTPay)
					data3 = [["","","Total:","#{pdfgetovertimeexist.to_s(:currency).gsub("$",'')  }"]]

					table(data1,:cell_style => { size: 7 },:column_widths => [70,20,40,60]) do
					columns(1..3).style(:align => :right)
					row(0..2).font_style = :bold
					cells.borders = []
					cells.padding = 1
					end

					table(data2,:cell_style => { size: 7 },:column_widths => [70,20,40,60]) do
					columns(1..3).style(:align => :right)
					cells.borders = []
					cells.padding = 1
					end

					table(data3,:cell_style => { size: 7 },:column_widths => [10, 60, 60, 60]) do
					columns(0..3).style(:align => :right)		
					row(0..3).font_style = :bold
					cells.padding = 1
					cells.borders = []
					end
				end

					##get other deductions
				if 	pdfgetotherdeductiontotals.to_f <= 0.01
					text""
				else
					%w[u].each do |tag|
 					text "<#{tag}>Other Deductions</#{tag}> ", :size => 7,:inline_format => true, :style =>:bold
					end

					data2 = ViewEmployeePayItemHistory.where(ProcessedPayrollRefNo: @pay_processed_payroll_u.ProcessedPayrollRefNo, EmployeeRefNo: @emprefno, IsDeduction: 1 ).pluck(:PayItem,:PAYITEMAMOUNT)
					data3 = [["","","Total:","#{pdfgetotherdeductiontotals}"]]

					
					table(data2,:cell_style => { size: 7 },:column_widths => [120,70]) do
					columns(1..3).style(:align => :right)
					cells.borders = []
					cells.padding = 1
					end

					table(data3,:cell_style => { size: 7 },:column_widths => [10, 60, 60, 60]) do
					columns(0..3).style(:align => :right)		
					row(0..3).font_style = :bold
					cells.padding = 1
					cells.borders = []
					end

				end 
				##end other deductions

	transparent(0) { stroke_bounds }
	end




	#end box for TABLE

	#IPI Logo
	#image "#{Prawn::DATADIR}/images/ipi.png", :position => 2,:vposition => 8,:width =>40
	image "#{Rails.root}/app/assets/images/p.png", :position => 2,:vposition => 8,:width =>40

	#Add pdf security
	encrypt_document(
    permissions: {
        print_document: true,
        modify_contents: false,
        copy_contents: true,
        modify_annotations: false
    	}
	)


#========================================
  end


end
