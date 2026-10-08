class Weeksched < Prawn::Document

	#start ini
	def initialize(emprefno, set_workdate_from, set_workdate_to )
		super(top_margin:10,left_margin: 10, right_margin: 10, :page_size => [841.89, 595.28])

		@emprefno = emprefno
		@set_workdate_from  = set_workdate_from
		@set_workdate_to = set_workdate_to 



		    pdfempdetails = PisEmploymentInfoU.where(EmployeeRefNo: @emprefno, IsActive: 1).pluck_to_hash(:EmployeeNumber, :PayFrequencyRefNo, :BasicRate, :TaxStatusRefNo, :JobPosition, :ClientAccountRefNo)

    		hashpdfPisEmployeeU = PisEmployeeU.where(EmployeeRefNo: @emprefno).pluck_to_hash(:Description, :FullName)

    		get_client = GenClientAccountM.where(ClientAccountRefno: hashpdfPisEmployeeU[0][:ClientAccountRefNo] ).pluck(:Description).to_sentence
    


	  	##START HEADER
		repeat :all do
	      #Create a bounding box and move it up 18 units from the bottom boundry of the page
	      bounding_box [bounds.left, bounds.top - 30 ], width: bounds.width do
	        text "Professional I.T. Solutions, Inc. (PITS)", size: 15, align: :center
	        #image "#{Rails.root}/app/assets/images/pits_14.PNG", :position => 180,:vposition => -7,:width =>85, :height => 30
	        move_down 5
	        text "ACTIVITY SHEET", size: 12, align: :center, :style =>:bold
	        move_down 5

	        data = [ ["NAME OF EMPLOYEE:","#{hashpdfPisEmployeeU[0][:Description]}","CLIENT/PROJECT", "#{get_client}"] ]

			table(data, :column_widths => [150, 260, 150,260 ], :cell_style => { size: 9 })do
					row(0..3).font_style = :bold
					end

			 
			data1 = [ ["DESIGNATION:","#{pdfempdetails[0][:JobPosition]}","PROJECT SUPERVISOR:", ""] ]
			table(data1, :column_widths => [150, 260, 150,260 ], :cell_style => { size: 9 })do
					row(0..3).font_style = :bold
					end



			move_down 10
			data2 = [ ["Work Date","Task Performed","Shift Start", "Shift End","Time in","Time out"] ]
			table(data2, :column_widths => [150, 260, 102,102,102,102], :cell_style => { size: 9 })do
					columns(0..5).style(:align => :center)
					row(0..5).font_style = :bold
					end

			transparent(0) { stroke_bounds }

	      end
	  	end
	  	##END HEADER


	  	##START TABLE
	    bounding_box [bounds.left, bounds.top - 181], width: bounds.width, height: 270 do
	      #Generate the rest of your PDF content here
				data3 = ViewConvertPortalDhsEmployeeWeeklyScheduleU.where(EmployeeRefNo: @emprefno, WorkDate: @set_workdate_from..@set_workdate_to ).pluck(:WorkDate_date,:task,:shif_start_datetime, :shif_end_datetime, :time_in_datetime,:time_out_datetime )


				table(data3,:cell_style => { size: 10 },:column_widths => [150, 260, 102,102,102,102]) do
				columns(1..5).style(:align => :left)
			end
			move_down 5
			text "*Report actual time logs and any changes to your shift will be communicated to you on this form.", size: 6, align: :left

	      transparent(0) { stroke_bounds }
	    end
	    ##END TABLE


	    ##START FOOTER
		repeat :all do
	      #Create a bounding box and move it up 18 units from the bottom boundry of the page / FOOTER
	      bounding_box [bounds.left, bounds.bottom + 100], width: bounds.width, :height => 300  do

	        data1 = [ ["PREPARED BY:","_________________________________________________","DATE:______________________________________________"] ]
			table(data1, :column_widths => [273,273,273 ], :cell_style => { size: 9 })do
					columns(1..3).style(:align => :center)
					row(0..2).font_style = :bold
					cells.borders = []
					cells.padding = 7
					end
			
			data2 = [ ["","(Signature Over Printed Name)",""] ]
			table(data2, :column_widths => [273,273,273 ],:cell_style => { size: 9 })do
					columns(1..3).style(:align => :center)
					row(0..2).font_style = :bold
					cells.borders = []
					cells.padding = 1
					end

			data3 = [ ["APPROVED BY IPI SUPERVISOR / TEAM LEAD:","_________________________________________________","DATE:______________________________________________"] ]
			table(data3, :column_widths => [273,273,273 ], :cell_style => { size: 9 })do
					columns(1..3).style(:align => :center)
					row(0..2).font_style = :bold
					cells.borders = []
					cells.padding = 7
					end

			data4 = [ ["RECEIVED BY (for Billing Purposes)","_________________________________________________","DATE:______________________________________________"] ]
			table(data4, :column_widths => [273,273,273 ], :cell_style => { size: 9 })do
					columns(1..3).style(:align => :center)
					row(0..2).font_style = :bold
					cells.borders = []
					cells.padding = 7
					end



	        text "Professional I.T. Solutions, Inc. (PITS) ", size: 7, align: :center
	        text "Ground floor, Arcadia Bldg. 860 Quezon Ave. Brgy. Paligsahan 1103, Quezon City", size: 7, align: :center
	        text "TEL. NOS.  +63284415755   MOBILE:  +639778369698", size: 7, align: :center
	        text "www.ipiphil.com", size: 7, align: :center
	        transparent(0) { stroke_bounds }
	      end
	  	end
	  	##END FOOTER




	end



	


end