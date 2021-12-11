class PortalTempAdsController < ApplicationController
  before_action :authenticate_user!

  def new
  	
  end


  def update_user_viewed_ads
    update_user1 = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
    update_user1.update(had_viewed_ads: 1)
    redirect_to pages_path
  end


end
