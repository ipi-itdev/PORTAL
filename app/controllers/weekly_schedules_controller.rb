class WeeklySchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weekly_schedule, only: [:edit]

  def index
    @weekly_schedules = WeeklySchedule.find_by_sql("select * from dbo.TMS_FN_GetEmployeeForRemark(#{current_user.EmployeeRefNo})")
  end

  def edit
    @get_edit_id = WeeklySchedule.find(params[:id])    
  end  

  private
    def set_weekly_schedule
      @weekly_schedule = WeeklySchedule.find(params[:id])
    end

    def weekly_schedule_params
      params.fetch(:weekly_schedule, {}).permit(:ID, :EmployeeRefNo, :EmployeeNumber, :Description, :JobPosition, :UserRefNo)
    end
end