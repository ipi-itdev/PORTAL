class PortalEmpvacCampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portal_empvac_campaign, only: %i[ show edit update destroy ]

  # GET /portal_empvac_campaigns or /portal_empvac_campaigns.json
  def index
    @portal_empvac_campaigns = PortalEmpvacCampaign.all
  end

  # GET /portal_empvac_campaigns/1 or /portal_empvac_campaigns/1.json
  def show
  end

  # GET /portal_empvac_campaigns/new
  def new
      checkuser_vaccampaign = PortalEmpvacCampaign.where(EmployeerRefNo: current_user.EmployeeRefNo).exists?

      if checkuser_vaccampaign ==  true
        redirect_to '/pages'
      else
        @portal_empvac_campaign = PortalEmpvacCampaign.new
      end
    
  end

  # GET /portal_empvac_campaigns/1/edit
  def edit
  end

  # POST /portal_empvac_campaigns or /portal_empvac_campaigns.json
  def create
    @portal_empvac_campaign = PortalEmpvacCampaign.new(portal_empvac_campaign_params)

    respond_to do |format|
      if @portal_empvac_campaign.save
        format.html { redirect_to '/pages' }
        #format.json { render :show, status: :created, location: @portal_empvac_campaign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @portal_empvac_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portal_empvac_campaigns/1 or /portal_empvac_campaigns/1.json
  def update
    respond_to do |format|
      if @portal_empvac_campaign.update(portal_empvac_campaign_params)
        format.html { redirect_to @portal_empvac_campaign, notice: "Portal empvac campaign was successfully updated." }
        format.json { render :show, status: :ok, location: @portal_empvac_campaign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @portal_empvac_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portal_empvac_campaigns/1 or /portal_empvac_campaigns/1.json
  def destroy
    @portal_empvac_campaign.destroy
    respond_to do |format|
      format.html { redirect_to portal_empvac_campaigns_url, notice: "Portal empvac campaign was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal_empvac_campaign
      @portal_empvac_campaign = PortalEmpvacCampaign.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portal_empvac_campaign_params
      params.require(:portal_empvac_campaign).permit(:EmployeerRefNo, :IsDone)
    end
end
