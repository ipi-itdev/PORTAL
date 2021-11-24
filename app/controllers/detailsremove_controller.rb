class DetailsremoveController < ApplicationController
  def index



  	 get_tre_details_rec = TreExpenseDetail.where(ID: params[:tre_detail_refno].to_i)
     get_tre_details_rec.destroy_all

     # flash[:notice] = "#{user_tre_expense.ID}"


    ## start compute total amount
      get_tredetails = TreExpenseDetail.where(ExpenseRefNo: session[:tre_expense_id]).pluck(:Amount)

        sum_tre = 0

        get_tredetails.each do |get_tredetails_1|
          get_tredetails_hash =  get_tredetails_1 
          get_tredetails_hash.to_f  
          sum_tre = get_tredetails_hash + sum_tre

        end

      user_tre_expense = TreExpense.find_by(ID: session[:tre_expense_id])
      user_tre_expense.Amount = sum_tre
      user_tre_expense.save

    ## end compute total amount



  	 redirect_to tre_expense_details_path and return

  end
end
  