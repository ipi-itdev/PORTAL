class TreExpenseDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tre_expense_detail, only: [:show, :edit, :update, :destroy]

  # GET /tre_expense_details
  # GET /tre_expense_details.json
  def index
    @get_url_valuex = request.original_url 

    @tre_expense_details = TreExpenseDetail.where(ExpenseRefNo: session[:tre_expense_id])
    @get_amount_sum = TreExpenseDetail.where(ExpenseRefNo: session[:tre_expense_id]).pluck_to_hash(:Amount)

    @testkolang = session[:tre_expense_id]

    render :layout => false
  end

  # GET /tre_expense_details/1
  # GET /tre_expense_details/1.json
  def show
    render :layout => false
  end

  # GET /tre_expense_details/new
  def new

    get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
    hash_get_emp_details = get_emp_details[0]
    get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first
    @get_manager_departments = GenDepartmentM.where(UserRefNo: get_manager_userrefno).pluck(:DepartmentRefNo)


    @tre_expense_detail = TreExpenseDetail.new
    render :layout => false
  end

  # GET /tre_expense_details/1/edit
  def edit
    get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
    hash_get_emp_details = get_emp_details[0]
    get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first
    @get_manager_departments = GenDepartmentM.where(UserRefNo: get_manager_userrefno).pluck(:DepartmentRefNo)

    render :layout => false
    
  end

  # POST /tre_expense_details
  # POST /tre_expense_details.json
  def create
    @tre_expense_detail = TreExpenseDetail.new(tre_expense_detail_params)

    respond_to do |format|
      if @tre_expense_detail.save

        ## start compute total amount
          get_tredetails = TreExpenseDetail.where(ExpenseRefNo: session[:tre_expense_id]).pluck(:Amount)

            sum_tre = 0

            get_tredetails.each do |get_tredetails_1|
              get_tredetails_hash =  get_tredetails_1 
              get_tredetails_hash.to_f  
              sum_tre = get_tredetails_hash + sum_tre

            end

          user_tre_expense = TreExpense.find_by(ID: session[:tre_expense_id])
          user_tre_expense.update(Amount: sum_tre)
        ## end compute total amount

        format.html { redirect_to tre_expense_details_path, notice: 'Expense Detail was successfully created.' }
        format.json { render :show, status: :created, location: @tre_expense_detail }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @tre_expense_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tre_expense_details/1
  # PATCH/PUT /tre_expense_details/1.json
  def update
    respond_to do |format|
      if @tre_expense_detail.update(tre_expense_detail_params)

        ## start compute total amount
          get_tredetails = TreExpenseDetail.where(ExpenseRefNo: session[:tre_expense_id]).pluck(:Amount)

            sum_tre = 0

            get_tredetails.each do |get_tredetails_1|
              get_tredetails_hash =  get_tredetails_1 
              get_tredetails_hash.to_f  
              sum_tre = get_tredetails_hash + sum_tre

            end

          user_tre_expense = TreExpense.find_by(ID: session[:tre_expense_id])
          user_tre_expense.update(Amount: sum_tre)
        ## end compute total amount


        #format.html { redirect_to @tre_expense_detail, notice: 'Tre expense detail was successfully updated.' }
        format.html { redirect_to tre_expense_details_path, notice: 'Expense Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @tre_expense_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @tre_expense_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def tre_detail_delete

    #get_tre_details_rec = TreExpenseDetail.where(ExpenseRefNo: @tre_expense.id)
    #get_tre_details_rec.destroy_all
    flash[:notice] = 'hello'
    redirect_to tre_expense_details_path

    render :layout => false
  end



  # DELETE /tre_expense_details/1
  # DELETE /tre_expense_details/1.json
  def destroy



    #@tre_expense_detail = TreExpenseDetail.where(ID:params[:ID])


      #redirect_to tre_expense_details_path



    @tre_expense_detail.destroy
    respond_to do |format|
      #format.html { redirect_to tre_expense_details_path, notice: 'Tre expense detail was successfully destroyed.' }
      #format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tre_expense_detail
      @tre_expense_detail = TreExpenseDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tre_expense_detail_params
      params.fetch(:tre_expense_detail, {}).permit(:ID, :ExpenseAttachmentRefNo, :ExpenseRefNo, :Description, :EmployeeRefNo, :AttachmentFile, :Amount, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :IsActive, :ServerCompanyCodeID, :ClientAccountRefNo, :tre_category_refno, :AttachmentFile_cache, :EntryRefNo)
    end
end


