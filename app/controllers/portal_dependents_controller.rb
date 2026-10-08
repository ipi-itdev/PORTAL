class PortalDependentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_dependent, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url     
    @portal_dependents = PortalDependent.where(EmployeeRefNo: current_user.EmployeeRefNo)
    
    render :layout => false
  end

  def show
    render :layout => false
  end

  def new    
    @portal_dependent = PortalDependent.new
    render :layout => false
  end

  def edit      
    render :layout => false
  end

  def create
    @portal_dependent = PortalDependent.new(portal_dependent_params)

    respond_to do |format|
      if @portal_dependent.save
        format.html { redirect_to portal_dependents_path, notice: 'Dependent was successfully created.' }        
        format.json { render :show, status: :created, location: @portal_dependent }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @portal_dependent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portal_dependent.update(portal_dependent_params)        
        format.html { redirect_to portal_dependents_path, notice: 'Dependent was successfully updated.' }
        format.json { render :show, status: :ok, location: @portal_dependent }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @portal_dependent.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_portal_dependent
      @portal_dependent = PortalDependent.find(params[:id])
    end

    def portal_dependent_params
      params.fetch(:portal_dependent, {}).permit(:ID, :EmployeeRefNo, :Description, :BirthDate, :Relationship, :IsPWD)
    end
end


