class WeeklyScheduleDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weekly_schedule_detail, only: [:edit, :update]

  def index
    @get_url_valuex = request.original_url     
    @weekly_schedule_details = WeeklyScheduleDetail.find_by_sql("select * from dbo.TMS_FN_GetWeeklySchedule(#{session[:weekly_schedule_id]})")
        
    render :layout => false
  end

  def edit      
    render :layout => false
  end

  def update
    respond_to do |format|
      if @weekly_schedule_detail.update(weekly_schedule_detail_params)        
        format.html { redirect_to weekly_schedule_details_path, notice: 'Weekly schedule detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_schedule_detail }
      else
        format.html { render :edit, :layout => false }
        format.json { render json: @weekly_schedule_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_weekly_schedule_detail
      @weekly_schedule_detail = WeeklyScheduleDetail.find(params[:id])
    end

    def weekly_schedule_detail_params
      params.fetch(:weekly_schedule_detail, {}).permit(:ID, :EmployeeRefNo, :WorkDate, :IsRD, :shift_start, :shift_end, :time_in, :time_out, :task, :Remarks)
    end
end