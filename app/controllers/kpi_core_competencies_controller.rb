class KpiCoreCompetenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kpi_core_competency, only: [:show, :edit, :update]

  def index
    @get_url_valuex = request.original_url     
    @kpi_core_competency = KpiCoreCompetency.all
    render :layout => false
  end

  def show
    render :layout => false
  end

  def new    
    @kpi_core_competency = KpiCoreCompetency.new
    render :layout => false
  end

  def edit      
    @get_edit_id = KpiCoreCompetency.find(params[:id])
    render :layout => false
  end

  def create
    @kpi_core_competency = KpiCoreCompetency.new(kpi_core_competency_params)
      
    respond_to do |format|
      if @kpi_core_competency.save
        format.html { redirect_to kpi_core_competencies_path, notice: 'KPI Detail was successfully created.' }
        format.json { render :show, status: :created, location: @kpi_core_competency }
      else
        format.html { render :new, :layout => false }
        format.json { render json: @kpi_core_competency.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @kpi_core_competency.update(kpi_core_competency_params)        
        flash[:notice] = "KPI detail was successfully updated."
        format.html { render :edit, :layout => false }        
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @kpi_core_competency.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_kpi_core_competency
      @kpi_core_competency = KpiCoreCompetency.find(params[:id])
    end

    def kpi_core_competency_params
      params.fetch(:kpi_core_competency, {}).permit(:ID, :CoreCompetency11, :CoreCompetency12, :CoreCompetency13, 
        :CoreCompetency21, :CoreCompetency22, :CoreCompetency23, :CoreCompetency31, :CoreCompetency32, :CoreCompetency33, 
        :CoreCompetency41, :CoreCompetency42, :CoreCompetency43, :CoreCompetency51, :CoreCompetency52, :CoreCompetency53,
        :CoreStrengthsHighest, :CoreStrengthsLowest, :ActionPlanA, :SpecialAssignment, :Objectives, :ActionPlanB)
    end
end