Rails.application.routes.draw do

    
  get 'portal_bir_uploaded_list', to: 'portal_bir_upload_details#portal_bir_uploaded_list'  
  get 'portal_bir_upload_confirmed', to: 'portal_bir_upload_details#portal_bir_upload_confirmed'
  get 'portal_bir_download_confirmed', to: 'portal_bir_upload_details#portal_bir_download_confirmed'
  post 'portal_bir_download_form_process', to: 'portal_bir_upload_details#portal_bir_download_form_process'
  get 'portal_bir_download_form', to: 'portal_bir_upload_details#portal_bir_download_form'
  resources :portal_bir_upload_details
  resources :portal_bir_uploads

  get 'workschedreportpdf', to: 'portal_dhs_employee_weekly_schedule_us#workschedreportpdf'
  get 'workschedreport', to: 'portal_dhs_employee_weekly_schedule_us#workschedreport'
  resources :inv_emp_accountability_us
  get 'leave_report_show', to: 'portal_leave_application_details#leave_report_show'
  get 'leave_report', to: 'portal_leave_application_details#leave_report'
  get 'ot_report_show', to: 'portal_ot_application_details#ot_report_show'
  get 'ot_report', to: 'portal_ot_application_details#ot_report'
  post '/remove_posterdetails', to: 'portal_homeposter_us#remove_posterdetails'
  post 'later_answer_syssurvey',  to: 'por_surveys#later_answer_syssurvey'
  get 'dtrhistory_ossreport', to: 'portal_dtr_histories#dtrhistory_ossreport'
  get 'dtrhistorydetails', to: 'portal_dhs_employee_weekly_schedule_us#dtrhistorydetails'  
  resources :portal_homeposter_details
  resources :portal_homeposter_us
  get 'Covid_9_Vax_Program', to: 'knowledges#Covid_9_Vax_Program'  
  get 'login_report', to: 'portal_dtr_histories#login_report'
  get 'login_logs', to: 'portal_dtr_histories#login_logs'
  get 'dependent_booster', to: 'portal_vacsurvey_us#dependent_booster'
  get 'booster_survey', to: 'portal_vacsurvey_us#booster_survey'
  resources :portal_vacbooster_surveys
  get '/winner', to: 'por_temp_surveys#winner'
  get 'portal_employee_satisfaction_surveys/intro'
  resources :portal_employee_satisfaction_surveys
  get 'portal_temp_ads/new'
  resources :portal_covidbulletins
  resources :portal_brgy_details_us
  get 'portal_tempwebinars/thank_you'
  resources :portal_empvac_campaigns
  resources :portal_vacsurvey_us
  resources :portal_ro_survey_us
  resources :portal_empposter_details
  resources :portal_posters
  get 'portal_tempwebinars/warning'
  resources :portal_tempwebinars
  get 'tmsdetailremove/index' 
  resources :portal_dtr_upload_details
  resources :portal_dtr_uploads
  resources :portal_dtr_histories
  resources :portal_dhs_employee_weekly_schedule_us
  resources :portal_employee_profiles
  resources :portal_leave_status_cs
  resources :portal_leave_time_lookup_us
  resources :portal_ob_approvals
  resources :portal_ob_applications
  resources :portal_ob_application_details
  resources :portal_ot_approvals
  resources :portal_ot_applications
  resources :portal_ot_application_details 
  resources :portal_leave_approvals 
  resources :portal_leave_applications
  resources :portal_leave_application_details
  resources :portal_dependents
  resources :portal_tre_applications
  resources :portal_tre_application_details
  resources :portal_change_requests
  resources :portal_change_request_details
  resources :weekly_schedules
  resources :weekly_schedule_details 
  resources :dtr_application_details
  resources :dtr_applications
  resources :portal_contacts
  resources :portal_contact_details
  resources :por_empmediadetails
  resources :por_media
  resources :portal_survey_covid19s
  mount Ckeditor::Engine => '/ckeditor'
  resources :por_temp_surveys
  resources :por_surveys 
  resources :privacies
  resources :ipiphils
  resources :knowledges
  resources :categories
  resources :payslipsettings
  resources :userheros
  resources :referrals
  resources :knowledgebases
  resources :renews
  resources :announcements
  resources :contactpages
  resources :pay_processed_payroll_us
  resources :pages
  resources :kpi_assignments
  resources :kpi_core_competencies

  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions", :passwords => "users/passwords" }
  #devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
      root to: 'users/sessions#new'
  end

  #root to: '/login'
  #root to: 'pages#index'
  #root to: 'pay_processed_payroll_us#index'

  #devise_scope :user do
  #   get 'login', to: 'users/sessions#new'
  #end

  #devise_scope :user do
  #   get 'signup', to: 'devise/registrations#new'
  #end

  devise_scope :user do
      get '/users', to: 'registrations#edit'
  end


  devise_scope :user do
      get '/users/password', to: 'devise/passwords#new'
  end

#for resend email
   devise_scope :user do
      get '/users/password/resendreset', to: 'users/passwords#resendreset'
  end


  devise_scope :user do
      post '/users/password/resendresetnow', to: 'users/passwords#resendresetnow'
  end


  devise_scope :user do
      get '/user_edit_password', to: 'users/passwords#user_edit_password'
  end

  devise_scope :user do
      post '/user_update_password', to: 'users/passwords#user_update_password'
  end

  devise_scope :user do
      get '/user_expire_password', to: 'users/passwords#user_expire_password'
  end

  devise_scope :user do
      post '/user_process_expire_password', to: 'users/passwords#user_process_expire_password'
  end

  scope :ipiphils do
    get  '/ipiphils/staffing', to: 'ipiphils#staffing'
    get  '/ipiphils/about', to: 'ipiphils#about'
    get  '/ipiphils/career', to: 'ipiphils#career'
  end

  post '/privacies/acknowledgeprivacy', to: 'privacies#acknowledgeprivacy'

  #weekschedhist
  get 'weekschedhist', to: 'portal_dhs_employee_weekly_schedule_us#weekschedhist'

  #dtrreport
  get 'dtrreport', to: 'portal_dtr_histories#dtrreport'

  #odhd
  get 'ODHD', to: 'dhs#ODHD'

  get 'BRGY', to: 'dhs#BRGY'

  ##pisaudit
  get 'pisaudit', to: 'pisaudit#pisaudit'

  ##schedule_confirmation
  get 'schedule_confirmation', to: 'portal_dhs_employee_weekly_schedule_us#schedule_confirmation'

  #emptimeout
  get 'emptimeout', to: 'portal_dhs_employee_weekly_schedule_us#emptimeout'

  #fixedschedule_page
  get 'fixedschedulepage', to: 'portal_dhs_employee_weekly_schedule_us#fixedschedulepage'

  ##vasurvey portal_vacsurvey_us
  get 'vacsurvey', to: 'portal_vacsurvey_us#vacsurvey'



  #############

  #update leave submit 
  post '/portal_leave_applications/leave_submit', to: 'portal_leave_applications#submit_application'

  #approver_internak_index
  get '/portal_leave_applications/approver/approver_index', to: 'portal_leave_applications#approver_index'

  #approver_external_index
  get '/portal_leave_applications/approver/extapprover_index', to: 'portal_leave_applications#extapprover_index'

  #approver_show
  get '/portal_leave_applications/approver/approver_edit', to: 'portal_leave_applications#approver_edit' 

  #approver_submit
  post '/portal_leave_applications/approver/approver_submit', to: 'portal_leave_applications#approver_submit'

  #show_submit
  post '/show_submit', to: 'portal_leave_applications#show_submit'

  #show_submit
  post '/auto_approve', to: 'portal_leave_applications#auto_approve'

  #my leave credits
  get 'leave_credits/index'

  #dept leave credits
  get 'leave_credits/dept_leave_credits'

  #tms
  post 'create_ob', to: 'portal_ob_applications#create_ob'
  post 'post_ob', to: 'portal_ob_applications#post_ob'

  post 'create_ot', to: 'portal_ot_applications#create_ot'
  post 'post_ot', to: 'portal_ot_applications#post_ot'

  post 'create_leave', to: 'portal_leave_applications#create_leave'
  post 'post_leave', to: 'portal_leave_applications#post_leave'

  post 'create_changerequest', to: 'portal_change_requests#create_changerequest'
  post 'post_changerequest', to: 'portal_change_requests#post_changerequest'

  #kpi
  post 'create_kpi', to: 'kpi_assignments#create_kpi'
  post 'post_kpi', to: 'kpi_assignments#post_kpi'
  get 'showkpireport', to: 'kpi_assignments#showkpireport'

  #tms approval
  post 'approve_dtr', to: 'dtr_applications#approve_dtr'
  post 'back_dtr', to: 'dtr_applications#back_dtr'
  post 'request_dtr', to: 'portal_dhs_employee_weekly_schedule_us#request_dtr'

  post 'approve_leave', to: 'portal_leave_approvals#approve_leave'
  post 'disapprove_leave', to: 'portal_leave_approvals#disapprove_leave'

  post 'approve_ot', to: 'portal_ot_approvals#approve_ot'
  post 'disapprove_ot', to: 'portal_ot_approvals#disapprove_ot'

  post 'approve_ob', to: 'portal_ob_approvals#approve_ob'
  post 'disapprove_ob', to: 'portal_ob_approvals#disapprove_ob'

  #dtr upload
  post 'create_dtr', to: 'portal_dtr_uploads#create_dtr'

  #tre tre_expenses
  post 'create_tre', to: 'portal_tre_applications#create_tre'
  post 'post_tre', to: 'portal_tre_applications#post_tre'

  #thank you survey
  get '/thank_you', to: 'por_temp_surveys#thank_you'

  #hrc_effectiveness_survey
  get'/hrc_effectiveness_survey', to: 'por_temp_surveys#hrc_effectiveness_survey'

  #confirm winner
  post '/confirm_winner', to: 'por_temp_surveys#confirm_winner'

  #for non existing routes
  get '*path' => redirect('/')
  
  # dhs button - page
  post 'verify_dhs', to: 'pages#verify_dhs'

  #dhs update sched
  post 'update_sched', to: 'portal_dhs_employee_weekly_schedule_us#update_sched'

  post '/later_reg', to: 'portal_tempwebinars#later_reg'

  post '/had_reg', to: 'portal_tempwebinars#had_reg'

  post '/cancel_webinar_reg', to: 'portal_tempwebinars#cancel_webinar_reg'
  
  post '/create_checker', to: 'portal_tempwebinars#create_checker'

  #temp survey later ans
  post '/ans_later', to: 'por_temp_surveys#ans_later'
  #temp survey no option
  post '/no_option', to: 'por_temp_surveys#no_option'

  #timein
  post '/timein', to: 'portal_dhs_employee_weekly_schedule_us#timein'

  #timeout
  post '/timeout', to: 'portal_dhs_employee_weekly_schedule_us#timeout'

  #fixed_sched
  post '/fixed_sched', to: 'portal_dhs_employee_weekly_schedule_us#fixed_sched'

  #confirm sched
  post '/confirm_sched', to: 'portal_dhs_employee_weekly_schedule_us#confirm_sched'

  #set_fixed_sched
  post '/set_fixed_sched', to: 'portal_dhs_employee_weekly_schedule_us#set_fixed_sched'

  #fixed_sched_set
  post 'fixed_sched_set', to: 'portal_dhs_employee_weekly_schedule_us#fixed_sched_set'

  #ans_pis_later
  post '/ans_pis_later', to: 'pisaudit#ans_pis_later'


  #update_user_had viewed ads
  post '/update_user_viewed_ads', to: 'portal_temp_ads#update_user_viewed_ads'


  
  #resources :pay_processed_payroll_us do
  #get :download_resume
  #end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end



