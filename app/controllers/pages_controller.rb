class PagesController < ApplicationController
  before_action :authenticate_user!

  #prepend_before_action :check_update_contact
  prepend_before_action :check_poster
  #prepend_before_action :check_dependent_booster
  #prepend_before_action :check_get_vac_booster
  #prepend_before_action :emp_satis_survey_checker
  prepend_before_action :check_user_tagconfirm
  prepend_before_action :check_user_viewed_ads
  #prepend_before_action :tempsurvey_checker
  prepend_before_action :check_covidbulletin
  #prepend_before_action :check_webinar_reg
  #prepend_before_action :check_vaccampaign
  #prepend_before_action :checker_oldpass
  prepend_before_action :checkadminloggedin, only: [:index]
  prepend_before_action :privacychecker, only: [:index]
  #prepend_before_action :checksurvey
  #prepend_before_action :covid_survey_checker
  prepend_before_action :check_pisaudit
  #prepend_before_action :check_BRGY
  #prepend_before_action :check_ODHD
  prepend_before_action :check_weeksched
  #prepend_before_action :check_vacdepsurvey
  #prepend_before_action :argreed_on_vac
  #prepend_before_action :check_vacsurvey
  prepend_before_action :check_ros_survey
  prepend_before_action :media_checker
  prepend_before_action :check_expire_password
  prepend_before_action :log_login
  prepend_before_action :check_current_user

  def index					
  	#get birthday month of User
  	@gettodayis = Time.now.strftime("%m")

    if current_user.EmployeeRefNo != 0
      getempdetails = PisEmployeeU.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck_to_hash(:Birthdate, :FirstName)
    
      if getempdetails[0][:Birthdate] != '1900-01-01 00:00:00.000'
        birthmonth = getempdetails[0][:Birthdate].to_date
        @getuserbday = birthmonth.to_date.strftime("%m") #Time.now.strftime("%m")			
      end	

      @getfname = getempdetails[0][:FirstName]
    else
      @getfname = current_user.EmployeeNumber
    end  	
  	#@getSA = SysWebUser.all
  	#@getemployee = PisEmployeeU.all
  	@datetodayis = Time.now.strftime("%B %d, %Y - %A")
  
  	#check announcements for all and per user
  	@getannouncements = Announcement.find_by_sql("SELECT * FROM PORTAL_Announcements_U  WHERE  post = 1 and EmployeeRefNo = #{current_user.EmployeeRefNo} UNION SELECT * FROM PORTAL_Announcements_U  WHERE  post = 1 AND EmployeeRefNo IS NULL").first(5)
  	#View Holiday
  	@getholidays = ViewGenHolidayM.all
  	#get quotes
  	#@quote = PorQuote.where(IsPost: true)

    ##start week sched
    @check_emp_client_acct =  PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck(:ClientAccountRefNo).to_sentence
    
    #current dattime      
    get_current_datetime = DateTime.now 

    @get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
    @current_datetime = @get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')
    @datetime_range = ActiveRecord::Base.connection.exec_query("SELECT * FROM fnSchedEmployee(#{current_user.EmployeeRefNo})")     
    ##end weeksched

    @srvy_checker = PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?

    #@emp_satis_srvy_checker =  PortalEmployeeSatisfactionSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? 
  end
  
  def update_user_ads
    update_user = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
    update_user.update(had_viewed_ads: 1)
    redirect_to pages_path
  end

  private
  def checker_oldpass
  	if current_user.blank?
  		flash[:success] = "Welcome!"	
  	else
     	ycur = User.where(id: current_user.id).pluck(:encrypted_password).to_sentence 
  	  if ycur.to_s == "$2a$11$txIf0M5feHeEkP4KGPkdf.5RCka0DHycG.bav3oKhlhzgEj.LTeFW"
  		  redirect_to '/users/password/new' and return
  	  else
  		  flash[:success] = "Welcome!"	
  		end
    end  			
  end

  #check if Admin for Admin Utilities
  private
  def checkadminloggedin
    if user_signed_in? == false
      @getuserrefno110 = 0      
    else
      @getuserrefno110 = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:IsAdmin).to_sentence
    end	
  end

  private
  def checksurvey
  	if user_signed_in? == false
  		redirect_to '/sign_in' and return
  	else
  		porsurveychecker = PorSurvey.exists?(EmployeeRefNo: current_user.EmployeeRefNo)
  		if porsurveychecker == false
  			redirect_to new_por_survey_path and return
  		end  	
  	end
  end

  private
  def privacychecker
  	if user_signed_in? == true    
      if current_user.IsAgreedPrivacy == false
  		  redirect_to new_privacy_path
  	  end
    end	
  end

  ##temp survey
  private
  def tempsurvey_checker
    if current_user.answer_survey_later == false
      if PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? == false
        redirect_to hrc_effectiveness_survey_path and return
      end

    else # answered survey later is false check later survey date
      if PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? == false
        if Date.today  >= current_user.LaterSurveyDate  
          redirect_to hrc_effectiveness_survey_path and return
        end
      end
    end
  end

  ##temp survey
  private
  def covid_survey_checker  	
  	if current_user.EmployeeGroupRefNo != '1'
  		check_covid_survey_exist = PortalSurveyCovid19.where(employeerefno: current_user.EmployeeRefNo).exists?
  		if check_covid_survey_exist == false
  			redirect_to new_portal_survey_covid19_path
  		end
  	end  			
  end

  private
  def check_update_contact
    if current_user.UpdatedContactInfo == false
      session[:contactedit] = 1
      ActiveRecord::Base.connection.execute("EXEC dbo.PIS_SP_PopulateUpdateContactInPortal @EmployeeRefNo = #{current_user.EmployeeRefNo}")

      redirect_to edit_portal_contact_path(id: current_user.EmployeeRefNo)
    end
  end

  private
  def check_BRGY
    if current_user.DoneBRGY == false
      redirect_to '/BRGY'
    end
  end

  def media_checker
    #get the last media refno
    get_user_info = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck_to_hash(:EmployeeRefNo, :last_media_refno)

    if get_user_info[0][:last_media_refno] == 0
      count_unfinished_media = ViewEmployeeMediaDetail.where(EmployeeRefNo:get_user_info[0][:EmployeeRefNo], endtime: nil).where.not(starttime: nil).first

      if count_unfinished_media.blank?
        count_new_media = ViewEmployeeMediaDetail.where(EmployeeRefNo: get_user_info[0][:EmployeeRefNo] , starttime: nil).count

        if count_new_media.blank? == false
          redirect_to new_por_empmediadetail_path
        end
      
      else
        #direct to unfinished media
        #flash[:notice] = " great new media x true - / #{count_unfinished_media.id}"
        redirect_to edit_por_empmediadetail_path(id: count_unfinished_media.id)
      end
    
    else # if last_media != 0
      #start loop
      ViewEmployeeMediaDetail.where(EmployeeRefNo: get_user_info[0][:EmployeeRefNo]).each do |empmediadetails|
        if empmediadetails.media_seq_refno <= get_user_info[0][:last_media_refno] 
          #nothing to do skip
          #flash[:notice] = " lesshant equal new media x true - #{get_user_info[0][:last_media_refno]}"
        else
          #flash[:notice] = " great new media x true - #{get_user_info[0][:last_media_refno]} / #{empmediadetails.media_seq_refno}"
          ##start checking unfinish
          get_unfinished_media = ViewEmployeeMediaDetail.where(EmployeeRefNo:get_user_info[0][:EmployeeRefNo], endtime: nil).where.not(starttime: nil).first
          if get_unfinished_media.blank?
            #flash[:notice] = " xxxx - #{get_unfinished_media}"
            redirect_to new_por_empmediadetail_path(:blank => "y") and return 
          else
            #direct to unfinished media
            #flash[:notice] = " xxxx unfinished- #{get_unfinished_media}"
            redirect_to edit_por_empmediadetail_path(id: get_unfinished_media.id) and return
          end
          ##end checking unfinish
        end
      end
      #end loop
    end
  end 

  private
  def check_current_user
    if user_signed_in? == false
      flash[:notice] = 'Session ended, Please try to login.'
      redirect_to '/'
    end    
  end

  def check_poster
    #get latest poster
    get_latest_poster_refno = PortalPoster.find_by_sql("select  top 1 * from portal_posters pp where start_date BETWEEN (SELECT DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)) and (select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime) ) order by start_date DESC ").pluck(:poster_refno).to_sentence
    if get_latest_poster_refno.blank? == false
      #get the last poster viewed by emp
      check_last_empposter_refno1 = PortalEmpposterDetail.where(employeerefno: current_user.EmployeeRefNo).pluck(:id, :poster_refno)
      check_last_empposter_refno = check_last_empposter_refno1[0]
      if check_last_empposter_refno[1].blank? == true
        redirect_to "/portal_empposter_details/#{check_last_empposter_refno[0]}/edit"
      else
        if check_last_empposter_refno[1].to_i < get_latest_poster_refno.to_i
          redirect_to "/portal_empposter_details/#{check_last_empposter_refno[0]}/edit"
        end   
      end  
    end 
  end

  def check_pisaudit    
    @PisEmploymentInfoU2 = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :PayFrequencyRefNo , :BasicRate, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo, :PayrollRateRefNo )[0]

    if current_user.EmployeeGroupRefNo == 1
      #for internal only
      if current_user.done_pisaudit == false
        if current_user.answer_pis_later == false
           redirect_to '/pisaudit' and return
        end
      end
    end
  end

  def check_weeksched
    if ActiveRecord::Base.connection.exec_query("Select CompanyRefNo from dbo.GEN_Company_M WHERE IsActive = 1").rows[0][0] == 1
      hashPisEmploymentInfoU = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :PayFrequencyRefNo , :BasicRate, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo, :PayrollRateRefNo )
      @PisEmploymentInfoU1 = hashPisEmploymentInfoU[0]

      if @PisEmploymentInfoU1[:EmployeeGroupRefNo] == 1 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 180 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 181 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 1390 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 1391 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 179 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 2432 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 3490 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 195
        #for internal only and p&g
        if current_user.sched_confirmed != true && current_user.fixed_sched != true
          redirect_to '/schedule_confirmation'
        end
      end

    else
      if current_user.sched_confirmed != true && current_user.fixed_sched != true
        redirect_to '/schedule_confirmation'
      end
    end
  end

  def check_ros_survey
    if current_user.EmployeeRefNo != 0     
      if current_user.EmployeeGroupRefNo != '1'        
  
        currentdate = Date.today
  
        if current_user.DeploymentDate <= currentdate
          if current_user.IsDoneROS == false
            redirect_to '/portal_ro_survey_us/new'
          end
        end 
      end
    end    
  end

  def check_vacsurvey
     get_vacsuvey_exist =  PortalVacsurveyU.where(EmployeeRefNo:current_user.EmployeeRefNo).exists?

     if get_vacsuvey_exist == false
        redirect_to '/portal_vacsurvey_us/new'
     end
  end

  def argreed_on_vac
    get_deploymentdate1 = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:DeploymentDate).to_sentence
    get_deploymentdate = get_deploymentdate1.to_date

    currentdate = Date.today

    if get_deploymentdate <= currentdate
      if current_user.IsDoneVacSurvey == false
        redirect_to '/vacsurvey'
      end
    end 
  end

  def check_vaccampaign
    if PortalEmpvacCampaign.where(EmployeerRefNo: current_user.EmployeeRefNo).exists? == false
      redirect_to new_portal_empvac_campaign_path
    end
  end

  def check_webinar_reg
    user_webinareg_value = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:webinareg_later).to_sentence

    if user_webinareg_value != 'true'
      redirect_to portal_tempwebinars_path
    end
  end

  def check_vacdepsurvey
    get_vacdepsuvey_exist =  PortalVacsurveyU.where(EmployeeRefNo:current_user.EmployeeRefNo, HasDependents: 1).exists?

    if get_vacdepsuvey_exist == true
      redirect_to '/vacdepsurvey'
    end
  end

  def check_expire_password
    dayexpire = ActiveRecord::Base.connection.exec_query("SELECT dbo.TMS_FN_GetSettingsValue(#{current_user.EmployeeRefNo},57,'1-1')").rows[0][0].to_s
    datechanged_datetime_plus_3mons = current_user.PasswordCreatedDate + dayexpire.to_i.days

    get_utc = ActiveRecord::Base.connection.exec_query("SELECT DATEADD(HOUR,8,GETUTCDATE())")

    if get_utc.rows[0][0] >= datechanged_datetime_plus_3mons
      redirect_to user_expire_password_path
    end
  end

  def log_login
    portal_login = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber)
    portal_login.save    
  end

  def check_covidbulletin
    if PortalCovidbulletin.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? == false
      redirect_to '/portal_covidbulletins/new'
    end  
  end

  def check_user_viewed_ads
    if current_user.had_viewed_ads.blank? == true
      redirect_to '/portal_temp_ads/new'
    end    
  end

  private
  def emp_satis_survey_checker
    #false
    if current_user.answer_survey_later != true
      emp_satis_surveycheck = PortalEmployeeSatisfactionSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?
      if emp_satis_surveycheck.blank? == true
        redirect_to '/portal_employee_satisfaction_surveys/intro' 
      end

    else # answered survey later is true check later survey date 
      emp_satis_surveycheck = PortalEmployeeSatisfactionSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?
      if emp_satis_surveycheck.blank? == true
        if Date.today  >= current_user.LaterSurveyDate  
        redirect_to '/portal_employee_satisfaction_surveys/intro' 
        end
      end
    end 
  end

  def check_user_tagconfirm
    if current_user.TagConfirmed != true
      redirect_to '/winner' 
    end
  end

  def check_get_vac_booster
    if current_user.DoneBooster != true
      redirect_to '/booster_survey'
    end
  end

  def check_dependent_booster
    if current_user.HasBoosterDependents == true
      redirect_to '/dependent_booster'
    end
  end
end