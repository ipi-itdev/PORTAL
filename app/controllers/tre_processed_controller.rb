class TreProcessedController < ApplicationController

  def index
  	@tre_processed = TreExpense.where(CreatedBy: current_user.EmployeeRefNo, FillingStatusRefNo: 22).or(TreExpense.where(CreatedBy: current_user.EmployeeRefNo, FillingStatusRefNo: 27))
  end


  def show
  	@get_tre_processed = TreExpense.where(ID: params[:tre_expense_id])
  end

  def details
  	@tre_processed_details = TreExpenseDetail.where(ExpenseRefNo: session[:tre_expense_id])
  	render :layout => false
  end

  def received
  	get_tre_processed_recieved = TreExpense.where(ID: params[:tre_expense_id_received])

  	get_tre_processed_recieved.each do|get_tre_processed_recieved1|

	  	get_tre_processed_recieved1.FillingStatusRefNo = 27
	  	get_tre_processed_recieved1.ReceivedDate = DateTime.now + 8.hours
	  	get_tre_processed_recieved1.save

  	end

  	flash[:notice] = "Marked as received. "
  	redirect_to tre_processed_index_path
  	
  end


end
