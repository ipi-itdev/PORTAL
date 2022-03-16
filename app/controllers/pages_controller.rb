class PagesController < ApplicationController
before_action :authenticate_user!

prepend_before_action :check_poster
prepend_before_action :check_dependent_booster
prepend_before_action :check_get_vac_booster
#prepend_before_action :emp_satis_survey_checker
prepend_before_action :check_user_tagconfirm
prepend_before_action :check_user_viewed_ads
#prepend_before_action :tempsurvey_checker
prepend_before_action :check_covidbulletin
prepend_before_action :check_webinar_reg
#prepend_before_action :check_vaccampaign
prepend_before_action :checker_oldpass, only: [:index] # Change this to be any actions you want to protect.
prepend_before_action :checkadminloggedin, only: [:index]
prepend_before_action :privacychecker, only: [:index]
#prepend_before_action :checksurvey
#prepend_before_action :covid_survey_checker
prepend_before_action :check_pisaudit
prepend_before_action :check_BRGY
prepend_before_action :check_ODHD

prepend_before_action :check_weeksched
prepend_before_action :check_vacdepsurvey
prepend_before_action :argreed_on_vac
#prepend_before_action :check_vacsurvey
prepend_before_action :check_ros_survey
prepend_before_action :media_checker
prepend_before_action :check_expire_password
prepend_before_action :log_login
prepend_before_action :check_current_user

  def index
        
     #get user refno
    getuserrefno1110 = current_user.EmployeeRefNo
    
    #get birthday month of User
    @gettodayis = Time.now.strftime("%m")
    getempdetails = PisEmployeeU.where(EmployeeRefNo: getuserrefno1110).pluck_to_hash(:Birthdate, :FirstName)

    
    #get employment info
    hash_getPisEmploymentInfoU = PisEmploymentInfoU.where(EmployeeRefNo: getuserrefno1110, IsActive: 1).pluck_to_hash(:EmployeeGroupRefNo, :DepartmentRefNo, :EmployeeRefNo )
    @getPisEmploymentInfoU = hash_getPisEmploymentInfoU[0]

    
    if getempdetails[0][:Birthdate] == '1900-01-01 00:00:00.000'

    else
      birthmonth = getempdetails[0][:Birthdate].to_date
      @getuserbday = birthmonth.to_date.strftime("%m") #Time.now.strftime("%m")
      
    end 
    
    @getfname = getempdetails[0][:FirstName]

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

   
        if @datetime_range.blank? == true
          #nothing to do
        else
          @get_rec_less_than_current_rec = PortalDhsEmployeeWeeklyScheduleU.find_by_sql("Select * from PORTAL_DHSEmployeeWeeklySchedule_U where EmployeeRefNo =  #{current_user.EmployeeRefNo} and WorkDate < '#{@datetime_range.rows[0][6]}' order by WorkDate DESC").first
        end  
        
      ##end weeksched

    @vac_finalist = PortalTempVacfinallist.where(EmployeeNumber: current_user.EmployeeNumber).exists?

    @srvy_checker = PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? 
    #@emp_satis_srvy_checker =  PortalEmployeeSatisfactionSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists? 


  end



  def ODHD
     # @ODHD_link = "https://dhs.ipiphil.com/#?pkey=1_#{current_user.EmployeeRefNo}"
  end


    def update_user_ad

      update_user = User.where(EmployeeRefNo: current_user.EmployeeRefNo)
      update_user.update(had_viewed_ads: 1)
      redirect_to pages_path
      
    end




    private
    def checker_oldpass
      if current_user.blank?
        flash[:success] = "Welcome!"  
      else

        xcur = current_user.id
        ycur = User.where(id: xcur).pluck(:encrypted_password).to_sentence
        ycur1 = ycur.to_s
        zcur = "$2a$11$txIf0M5feHeEkP4KGPkdf.5RCka0DHycG.bav3oKhlhzgEj.LTeFW"

      if ycur1.to_s ==  zcur.to_s
        redirect_to '/users/password/new' and return
      else
        flash[:success] = "Welcome!"  
        end
    end       
    end

    #start check if Admin for Admin Utilities
    private
    def checkadminloggedin

    if user_signed_in? == false
      @getuserrefno110 = 0
      
    else
      getuserrefno110x = current_user.EmployeeRefNo
      @getuserrefno110 = User.where(EmployeeRefNo: getuserrefno110x).pluck(:IsAdmin).to_sentence
    end 

    end

    # end check if Admin for Admin Utilities


    private
    def checksurvey
      if user_signed_in? == false
        redirect_to '/sign_in' and return
      else
        porsurveychecker = PorSurvey.exists?(EmployeeRefNo: current_user.EmployeeRefNo)
        if porsurveychecker == true
        else
          redirect_to '/por_surveys/new' and return
        end
      end
    end

    ##start privacychecker
    private
    def privacychecker
      if user_signed_in? == false
    else
      isagreedprivacy = current_user.IsAgreedPrivacy
      if isagreedprivacy == true
      else
        redirect_to '/privacies/new'
      end
    end 
    end
    ##end privacychecker


    ##temp survey
    private
    def tempsurvey_checker

      if current_user.answer_survey_later == false
        tempsurveycheck = PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?
        if tempsurveycheck == false
          redirect_to hrc_effectiveness_survey_path and return
        end

      else # answered survey later is false check later survey date
        tempsurveycheck1 = PorTempSurvey.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?
        if tempsurveycheck1 == false
          if Date.today  >= current_user.LaterSurveyDate  
          redirect_to hrc_effectiveness_survey_path and return
          end
        end
      end
      
    end
    ##temp survey

    

    #start check covid survey
    private
    def covid_survey_checker

      get_emp_group = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck(:EmployeeGroupRefNo).to_sentence

      if get_emp_group == '1' #for internal
        #flash[:notice] = "internal#{get_emp_group}"
      else #for external
        #flash[:notice] = "external#{get_emp_group}"
        check_covid_survey_exist = PortalSurveyCovid19.where(employeerefno: current_user.EmployeeRefNo).exists?

        if check_covid_survey_exist == true
          #nothing to do
        else ##false
          redirect_to new_portal_survey_covid19_path
        end

      end
          
    end
    #end check covid survey

    #start check_survey
  
    def check_ODHD

          if current_user.DoneDHS == true
            #nothing
          else
            redirect_to '/ODHD'
          end

      
    end
    #end check_survey

    
    ## start media checker
    def media_checker
      #get the last media refno
      get_user_info = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck_to_hash(:EmployeeRefNo, :last_media_refno)


       if get_user_info[0][:last_media_refno] == 0

        #flash[:notice] = "blank"
        count_unfinished_media = ViewEmployeeMediaDetail.where(EmployeeRefNo:get_user_info[0][:EmployeeRefNo], endtime: nil).where.not(starttime: nil).first

        if count_unfinished_media.blank?

          count_new_media = ViewEmployeeMediaDetail.where(EmployeeRefNo: get_user_info[0][:EmployeeRefNo] , starttime: nil).count

          if count_new_media.blank?
            ## nothing to do
            #no new media   
            #flash[:notice] = " no new media for user"
            #redirect_to new_por_empmediadetail_path

          else
            #nothing to do
            #flash[:notice] = "redirect to - #{count_new_media}"
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

          if  empmediadetails.media_seq_refno <= get_user_info[0][:last_media_refno] 
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
    ## end media checker


    ##start check if user signed in
    private
    def check_current_user

      if user_signed_in? == true
        #nothing to do
      else
        flash[:notice] = 'Session ended, Please try to login.'
        redirect_to '/'
      end
      
    end

    ## endcheck if user signed in

    ##start check posterviewer
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
    ##end check posterviewer



    ## start pis_audit
    def check_pisaudit
      hashPisEmploymentInfoU = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :PayFrequencyRefNo , :BasicRate, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo, :PayrollRateRefNo )
      @PisEmploymentInfoU2 = hashPisEmploymentInfoU[0]

       if @PisEmploymentInfoU2[:EmployeeGroupRefNo] == 1

            #for internal only
            if current_user.done_pisaudit == true
              #nothing to do
            else

                if current_user.answer_pis_later == true
                    #nothing to do
                else
                   redirect_to '/pisaudit' and return
                end

            end

      else
        #nothing to do ext emp
      end
  
    end
    ## end pis_audit


    ##check weeksched
    def check_weeksched


      hashPisEmploymentInfoU = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck_to_hash(:ClientAccountRefNo, :PayFrequencyRefNo , :BasicRate, :EmployeeGroupRefNo, :JobPosition,:DepartmentRefNo, :PayrollRateRefNo )
      @PisEmploymentInfoU1 = hashPisEmploymentInfoU[0]
      
      if @PisEmploymentInfoU1[:EmployeeGroupRefNo] == 1 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 180 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 181 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 1390 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 1391 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 179 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 2432  || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 3490 || @PisEmploymentInfoU1[:ClientAccountRefNo].to_i == 195

        #for internal only and p&g
        if current_user.sched_confirmed != true && current_user.fixed_sched != true
          redirect_to '/schedule_confirmation'
        end

      else
        #nothing to do ext emp
      end 
      
    end
    ##check weeksched


    ##start check ros_survey
    def check_ros_survey

        #get_emp_grp 
        get_emp_grp = PisEmploymentInfoU.where(EmployeeRefNo: current_user.EmployeeRefNo, IsActive: 1).pluck(:EmployeeGroupRefNo).to_sentence


        #check if external emp
        if get_emp_grp == '1'
          #nothing to do
        else
          #flash[:notice] = 'test'
          #get deployment date
          get_deploymentdate1 = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:DeploymentDate).to_sentence
          get_deploymentdate = get_deploymentdate1.to_date

          #get currentdate
          currentdate = Date.today

          #check if depdate = currentdate
          if get_deploymentdate <= currentdate

            #check IsDoneROS flag
            if current_user.IsDoneROS == true
              #nothing to do
            else
              redirect_to '/portal_ro_survey_us/new'
            end

          else
              #nothing to do
          end 

        end

    end
    ##end check ros_survey



    ##start check vacsurvey
    def check_vacsurvey

       get_vacsuvey_exist =  PortalVacsurveyU.where(EmployeeRefNo:current_user.EmployeeRefNo).exists?

       if get_vacsuvey_exist == true
          #nothing to do
       else
          redirect_to '/portal_vacsurvey_us/new'
       end
      
    end
    ##end check vacsurvey

        
    ##check argreed_on_vac
    ##check argreed_on_vac
    def argreed_on_vac
      get_deploymentdate1 = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:DeploymentDate).to_sentence
      get_deploymentdate = get_deploymentdate1.to_date

      #get currentdate
      currentdate = Date.today

        #check if depdate = currentdate
      if get_deploymentdate <= currentdate

        #check IsDoneVacSurvey flag
        if current_user.IsDoneVacSurvey == true
          #nothing to do
        else
          redirect_to '/vacsurvey'
        end

      else
          #nothing to do
      end 

    end
    ##check argreed_on_vac
    ##check argreed_on_vac




    ##start check vacdepsurvey
    def check_vacdepsurvey

       get_vacdepsuvey_exist =  PortalVacsurveyU.where(EmployeeRefNo:current_user.EmployeeRefNo, HasDependents: 1).exists?

       if get_vacdepsuvey_exist == true
          redirect_to '/vacdepsurvey'
       else
          #nothing to do
       end
      
    end
    ##end check vacdepsurvey



    #start check_vaccampaign
    def check_vaccampaign
      checkuser_vaccampaign = PortalEmpvacCampaign.where(EmployeerRefNo: current_user.EmployeeRefNo).exists?

      if checkuser_vaccampaign ==  true
        #nothing to do
      else
        redirect_to new_portal_empvac_campaign_path
      end

    end
    #end check_vaccampaign


        
    #start check_webinar_reg
    def check_webinar_reg
      user_webinareg_value = User.where(EmployeeRefNo: current_user.EmployeeRefNo).pluck(:webinareg_later).to_sentence

      if user_webinareg_value != 'true'
        redirect_to portal_tempwebinars_path
      end
    end
    # end check_webinar_reg

        
    #start check_expire_password
    def check_expire_password
    get_latest_datechanged = PortalPasswordBank.where(EmployeeRefNo: current_user.EmployeeRefNo, IsCurrent: 1).pluck(:DateChanged)

      if get_latest_datechanged.empty? == true #record exists on pass bank
          redirect_to user_expire_password_path
          
      else #no record on pass bank
        
          get_latest_datechanged_convert = get_latest_datechanged.to_sentence
          datechanged_datetime =  get_latest_datechanged_convert.to_datetime
          datechanged_datetime_plus_3mons =  datechanged_datetime + 3.months
          get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
          current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')  

           if current_datetime >= datechanged_datetime_plus_3mons  #true
              redirect_to user_expire_password_path
           else #false
            #nothing to do
           end
      end

    end
    #end check_expire_password


    #check login log
    def log_login

      get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
      current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S') 

      portal_login  = PortalLoginLog.create(EmployeeRefNo: current_user.EmployeeRefNo, EmployeeNumber: current_user.EmployeeNumber, Time_Login: current_datetime)
      portal_login.save
      
    end
    #check login log

    def check_BRGY
        if current_user.LaterBRGY == false
         if current_user.DoneBRGY == false
          redirect_to '/BRGY'
         end
        end
    end


    #check covid bulletins
    def check_covidbulletin
       get_emp_exists = PortalCovidbulletin.where(EmployeeRefNo: current_user.EmployeeRefNo).exists?

      if get_emp_exists == false
        redirect_to '/portal_covidbulletins/new'
      end  

    end
    #check covid bulletins

      
  def check_user_viewed_ads

    if current_user.had_viewed_ads.blank? == true
      redirect_to '/portal_temp_ads/new'
    end
    
  end

  
  #check_user_tagconfirm
  def check_user_tagconfirm
    if current_user.TagConfirmed != true
      redirect_to '/winner' 
    end
  end
  #check_user_tagconfirm


  #check emp_satis_survey
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
  #check emp_satis_survey


  #check vac booster
  def check_get_vac_booster
    if current_user.DoneBooster != true
      redirect_to '/booster_survey'
    end
  end
  #check vac booster


  #check_dependent_booster
  def check_dependent_booster
    if current_user.HasBoosterDependents == true
      redirect_to '/dependent_booster'
    end
  end
  #check_dependent_bootser





end
