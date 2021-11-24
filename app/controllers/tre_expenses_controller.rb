class TreExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tre_expense, only: [:show, :edit, :update, :destroy]

  # GET /tre_expenses
  # GET /tre_expenses.json
  def index
    #@tre_expenses = TreExpense.where(CreatedBy: current_user.EmployeeRefNo).where.not(FillingStatusRefNo: 27).and(TreExpense.where(CreatedBy: current_user.EmployeeRefNo).where.not(FillingStatusRefNo: 22))

      @tre_expenses = TreExpense.find_by_sql("select * from TRE_Expense_U where (CreatedBy = #{current_user.EmployeeRefNo} and  FillingStatusRefNo <> 22) and (CreatedBy = #{current_user.EmployeeRefNo} and FillingStatusRefNo <> 27 )")

  
  end

  # GET /tre_expenses/1
  # GET /tre_expenses/1.json
  def show

  end

  # GET /tre_expenses/new
  def new
    @tre_expense = TreExpense.new
  end

  # GET /tre_expenses/1/edit
  def edit
    @get_edit_id = TreExpense.find(params[:id])
  end

  # POST /tre_expenses
  # POST /tre_expenses.json
  def create
    @tre_expense = TreExpense.new(tre_expense_params)

    respond_to do |format|
      if @tre_expense.save
        format.html { redirect_to @tre_expense, notice: 'Tre expense was successfully created.' }
        format.json { render :show, status: :created, location: @tre_expense }
      else
        format.html { render :new }
        format.json { render json: @tre_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tre_expenses/1
  # PATCH/PUT /tre_expenses/1.json
  def update
    respond_to do |format|
      if @tre_expense.update(tre_expense_params)

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

        format.html { redirect_to '/tre_expenses', notice: 'TRE Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @tre_expense }
      else
        format.html { render :edit }
        format.json { render json: @tre_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tre_expenses/1
  # DELETE /tre_expenses/1.json
  def destroy
    @tre_expense.destroy

        get_tre_details_rec = TreExpenseDetail.where(ExpenseRefNo: @tre_expense.id)
        get_tre_details_rec.destroy_all


    respond_to do |format|
      format.html { redirect_to tre_expenses_url, notice: 'TRE Expense was successfully removed.' }
      format.json { head :no_content }
    end
  end


  def create_tre

      tre_expense_save  = TreExpense.new
      tre_expense_save.CreatedBy = current_user.EmployeeRefNo
      tre_expense_save.CreatedDate = DateTime.now + 8.hours
      tre_expense_save.ModifiedDate = DateTime.now + 8.hours
      tre_expense_save.ModifiedBy = current_user.EmployeeRefNo
      tre_expense_save.FillingStatusRefNo = 1
      tre_expense_save.IsActive = true
      tre_expense_save.ServerCompanyCodeID = '1-1'
      get_deptrefno = PisEmploymentInfoU.where(EmployeeRefNo:current_user.EmployeeRefNo, IsActive: 1).pluck(:DepartmentRefNo).to_sentence
      tre_expense_save.DepartmentRefNo = get_deptrefno
      tre_expense_save.save

      redirect_to edit_tre_expense_path(id: tre_expense_save.id)
      #redirect_to tre_expenses_path
      flash[:notice] = "TRE Expense was created"

    
  end


  def post_tre

    tre_expense_rec_checker = TreExpense.where(ID: params[:tre_id]).pluck(:Amount).to_sentence

    #flash[:notice] = "#{tre_expense_rec_checker == '0.0'}"

    if tre_expense_rec_checker == '0.0'

        flash[:notice] = "Missing Total Amount."
        redirect_to "/tre_expenses/#{params[:tre_id]}/edit"

    else

          tre_expense_rec = TreExpense.where(ID: params[:tre_id])
    
          tre_expense_rec.each do |tre_expense_rec1|
            tre_expense_rec1.FillingStatusRefNo = 4
            tre_expense_rec1.save
          end

        ##send email
        get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
        hash_get_emp_details = get_emp_details[0]
        get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first

        @get_manager_userrefno = get_manager_userrefno
        @get_tre_reference_no = params[:tre_id]

        UserMailer.tre_mngr_approval_email(@get_manager_userrefno, @get_tre_reference_no ).deliver_now

        ## end send email 


        flash[:notice] = "Record has been posted."
        redirect_to tre_expenses_path

      
    end


  end




  def index_managers_tre

    if current_user.is_gen_manager ==  true 

      @view_tre_int_emp_dept = ViewTreIntEmpDept.where(FillingStatusRefNo: 23).where.not(CreatedBy: current_user.EmployeeRefNo)

    elsif current_user.is_ceo ==  true
       
      @view_tre_int_emp_dept = ViewTreIntEmpDept.where(FillingStatusRefNo: 25).where.not(CreatedBy: current_user.EmployeeRefNo)   

    else

      get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
      hash_get_emp_details = get_emp_details[0]
      get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first
      get_manager_departments = GenDepartmentM.where(UserRefNo: get_manager_userrefno).pluck(:DepartmentRefNo)

      #@x = ViewTreIntEmpDept.where(EmpDepRefNo: get_manager_departments.map(&:to_i))
      #@view_tre_int_emp_dept = ViewTreIntEmpDept.where(EmpDepRefNo: get_manager_departments.map(&:to_i)).where.not(CreatedBy: current_user.EmployeeRefNo, FillingStatusRefNo: 1)
      @view_tre_int_emp_dept = ViewTreIntEmpDept.where(FillingStatusRefNo: 4).where.not(CreatedBy: current_user.EmployeeRefNo)
    end 



  end


  def tre_manager_submit

    get_tre_rec = TreExpense.where(ID: params[:tre_ref_no])

    get_tre_rec.each do |get_tre_rec1|
      get_tre_rec1.FillingStatusRefNo = params[:filing_status]
      get_tre_rec1.ModifiedDate = DateTime.now + 8.hours
      get_tre_rec1.ModifiedBy = current_user.EmployeeRefNo
      get_tre_rec1.save
    end

    ##send email
    get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
    hash_get_emp_details = get_emp_details[0]
    get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first

    @get_manager_userrefno = get_manager_userrefno
    @get_tre_reference_no = params[:tre_ref_no]

    UserMailer.tre_mngr_approval_email(@get_manager_userrefno, @get_tre_reference_no ).deliver_now

    ## end send email 

    redirect_to index_managers_tre_path
  end


  def tre_manager_post
    
    get_tre_rec = TreExpense.where(ID: params[:tre_id])

    get_tre_rec.each do|get_tre_rec1|
      get_tre_rec1.FillingStatusRefNo = 23
      get_tre_rec1.ModifiedDate = DateTime.now + 8.hours
      get_tre_rec1.ModifiedBy = current_user.EmployeeRefNo
      get_tre_rec1.save
    end
    
    flash[:notice] = "Record Posted"
    redirect_to tre_expenses_path

  end



  def tre_manager_post
    
    get_tre_rec = TreExpense.where(ID: params[:tre_id])

    get_tre_rec.each do|get_tre_rec1|
      get_tre_rec1.FillingStatusRefNo = 23
      get_tre_rec1.ModifiedDate = DateTime.now + 8.hours
      get_tre_rec1.ModifiedBy = current_user.EmployeeRefNo
      get_tre_rec1.save
    end
    
    flash[:notice] = "Record Posted"
    redirect_to tre_expenses_path

  end




  def tre_gm_submit

    get_tre_rec = TreExpense.where(ID: params[:tre_ref_no])

    get_tre_rec.each do |get_tre_rec1|
      get_tre_rec1.FillingStatusRefNo = params[:filing_status]
      get_tre_rec1.ModifiedDate = DateTime.now + 8.hours
      get_tre_rec1.ModifiedBy = current_user.EmployeeRefNo
      get_tre_rec1.save
    end

    ##send email
    get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
    hash_get_emp_details = get_emp_details[0]
    get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first

    @get_manager_userrefno = get_manager_userrefno
    @get_tre_reference_no = params[:tre_ref_no]

    UserMailer.tre_mngr_approval_email(@get_manager_userrefno, @get_tre_reference_no ).deliver_now

    ## end send email 

    redirect_to index_managers_tre_path
  end


  def tre_gm_post
    
    get_tre_rec = TreExpense.where(ID: params[:tre_id])

    get_tre_rec.each do|get_tre_rec1|
      get_tre_rec1.FillingStatusRefNo = 25
      get_tre_rec1.ModifiedDate = DateTime.now + 8.hours
      get_tre_rec1.ModifiedBy = current_user.EmployeeRefNo
      get_tre_rec1.save
    end

    flash[:notice] = "Record Posted"
    redirect_to tre_expenses_path

  end



  def tre_ceo_submit
    
    get_tre_rec = TreExpense.where(ID: params[:tre_ref_no])

    get_tre_rec.each do |get_tre_rec1|
      get_tre_rec1.FillingStatusRefNo = params[:filing_status]
      get_tre_rec1.ModifiedDate = DateTime.now + 8.hours
      get_tre_rec1.ModifiedBy = current_user.EmployeeRefNo
      get_tre_rec1.save
    end

    ##send email
    get_emp_details = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo)
    hash_get_emp_details = get_emp_details[0]
    get_manager_userrefno = GenDepartmentM.where(DepartmentRefNo: hash_get_emp_details[:DepartmentRefNo]).pluck(:UserRefNo).first

    @get_manager_userrefno = get_manager_userrefno
    @get_tre_reference_no = params[:tre_ref_no]

    UserMailer.tre_mngr_approval_email(@get_manager_userrefno, @get_tre_reference_no ).deliver_now

    ## end send email 


    redirect_to index_managers_tre_path


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tre_expense
      @tre_expense = TreExpense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tre_expense_params
      params.fetch(:tre_expense, {}).permit(:ID, :ExpenseRefNo, :Description, :ClientAccountRefNo, :DepartmentRefNo, :Amount, :Date, :FillingStatusRefNo, :IsPrinted, :CreatedBy, :ModifiedBy, :CreatedDate, :ModifiedDate, :CompanyRefNo)

    end
end
