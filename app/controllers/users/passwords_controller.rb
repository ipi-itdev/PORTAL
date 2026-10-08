# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :authenticate_user!, only: [:resendreset]
  prepend_before_action :require_no_authentication, :only => [:edit, :update] # <- added this :require_no_authentication, :only => [:edit, :update] for reset password when user was login.
  # Render the #edit only if coming from a reset password email link
  append_before_action :assert_reset_token_passed, only: :edit
  #prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.
  prepend_before_action :adminchecker, only: [:resendreset]
  prepend_before_action :checkadminloggedin

  



  # GET /resource/password/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
 
    yield resource if block_given? 

    if successfully_sent?(resource)
      #respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      if current_user.blank?
        sign_out current_user
        redirect_to '/', :alert => "You will receive an email with instructions on how to reset your password in a few minutes."
      else
        sign_out current_user
        redirect_to '/'
      end
      
    else
      
      respond_with(resource)

    end
    
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update

    get_decrypt_token = Devise.token_generator.digest(User,:reset_password_token, "#{resource_params[:reset_password_token]}")

    get_user_with_resetpasstoken = User.where(reset_password_token: get_decrypt_token)

    get_emprefno = 0
    get_user_with_resetpasstoken.each do |get_user_with_resetpasstoken|

      get_emprefno = get_user_with_resetpasstoken.EmployeeRefNo
        
    end

    #check if token exista
    if get_user_with_resetpasstoken.exists? ==  true

          #check if newpass and confirmpass are same
          if resource_params[:password] == resource_params[:password_confirmation]#true
            #check if newpass and confirmpass are empty
            if resource_params[:password] != '' || resource_params[:password_confirmation] != ''#true
              #check if user was existing on the bank
              get_emp_on_bank= PortalPasswordBank.where(EmployeeRefNo: get_emprefno ).exists?

              if get_emp_on_bank == true #emp exists
                #check if pass was not existing and over one year
                params_new_pass = resource_params[:password]
              
                #get current date
                get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
                current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S') 

                #check if password existing on bank
                emp_rec_bank = PortalPasswordBank.where(EmployeeRefNo: get_emprefno )

                counter_check = 0
                array_id_collect = []

                emp_rec_bank.each do |emp_rec_bank|
                  emp_rec_bank_password_convert = BCrypt::Password.new(emp_rec_bank.Password)

                  if emp_rec_bank_password_convert == params_new_pass
                      
                     counter_check = counter_check + 1 
                     array_id_collect << emp_rec_bank.ID

                  end 
                end


                if counter_check > 0 #password exists -  check if existing is within one year

                    emprec = PortalPasswordBank.find_by_sql("select top 1 * from portal_password_bank where id in (#{array_id_collect.compact.join(',')}) order by DateChanged asc")

                    check_within_1yr = ''
                    emprec.each do |emprec|
                        get_existing_datechanged_plus_1yr = emprec.DateChanged + 1.year
                        check_within_1yr = current_datetime.between? emprec.DateChanged, get_existing_datechanged_plus_1yr

                    end

                    if check_within_1yr == true #password was used within 1 year

                      flash[:notice] = "Cannot use old password."
                      redirect_to "/users/password/edit?reset_password_token=#{resource_params[:reset_password_token]}"  and return

                    else #password out side 1year - save new password 
                      #add emp-pass on bank / update users pass
                      get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
                      current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

                      get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: get_emprefno )
                      get_existing_passbank.update(IsCurrent: false) 

                      get_new_password = encrypted_password_in_database = BCrypt::Password.create(resource_params[:password])
                 
                      save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: get_emprefno, Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
                      save_pass_bank.save

                      user = User.find_by(EmployeeRefNo: get_emprefno)
                      user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

                      flash[:notice] = 'Successfully saved new password, please login again...'
                      redirect_to new_user_session_path and return
                      
                    end


                else #password does not exists will create new password

                  #add emp-pass on bank / update users pass
                  get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
                  current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

                  get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: get_emprefno)
                  get_existing_passbank.update(IsCurrent: false) 

                  get_new_password = encrypted_password_in_database = BCrypt::Password.create(resource_params[:password])
             
                  save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: get_emprefno, Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
                  save_pass_bank.save

                  user = User.find_by(EmployeeRefNo: get_emprefno)
                  user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

                  flash[:notice] = 'Successfully saved new password, please login again..'
                  redirect_to new_user_session_path and return
                  
                end

              else # emp not exists on pass bank
                #add emp-pass on bank / update users pass
                get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
                current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')


                get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: params[:emprefno])
                get_existing_passbank.update(IsCurrent: false)  

                get_new_password = encrypted_password_in_database = BCrypt::Password.create(resource_params[:password])

                save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: get_emprefno, Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
                save_pass_bank.save

                user = User.find_by(EmployeeRefNo: get_emprefno)
                user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

                flash[:notice] = 'Successfully saved new password, please login again.'
                redirect_to new_user_session_path and return

              end

            else
              flash[:notice] = 'Please enter New Password / Confirm Password'
              redirect_to "/users/password/edit?reset_password_token=#{resource_params[:reset_password_token]}"  and return
            end

          else  
            flash[:notice] = 'New Password and Confirm Password did not matched.'
            redirect_to "/users/password/edit?reset_password_token=#{resource_params[:reset_password_token]}"    and return
          end 

    else
          flash[:notice] = 'Sorry, password token does not exists.'
          redirect_to "/users/password/edit?reset_password_token=#{resource_params[:reset_password_token]}"    and return
    end

    ## start default procedure
    #self.resource = resource_class.reset_password_by_token(resource_params)
    #yield resource if block_given?

    #if resource.errors.empty?
    #  resource.unlock_access! if unlockable?(resource)
    #  if Devise.sign_in_after_reset_password
    #    flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
    #    set_flash_message!(:notice, flash_message)
    #    resource.after_database_authentication
    #    sign_in(resource_name, resource)
    #  else
    #    set_flash_message!(:notice, :updated_not_active)
    #  end
    #  respond_with resource, location: after_resetting_password_path_for(resource)
    #else
    #  set_minimum_password_length
    #  respond_with resource
    #end
    ## end default procedure

  end


    # mass maill send function query = /users/password/resendreset
   def resendreset
        #@resendlist = User.find_by_sql("select * from users where email != 'noemail' and encrypted_password ='$2a$11$txIf0M5feHeEkP4KGPkdf.5RCka0DHycG.bav3oKhlhzgEj.LTeFW'")
      @resendlist = User.find_by_sql("SELECT c.* FROM users c
      inner join PIS_Employee_U a ON c.EmployeeRefNo = a.EmployeeRefNo
      INNER JOIN  PIS_EmploymentInfo_U b ON a.EmployeeRefNo = b.EmployeeRefNo AND b.IsActive = 1
      WHERE b.EmployeeGroupRefNo = 2   
      AND c.email <> 'noemail' AND IsNull(c.IsSend,0) <> 1")
      
      @resendlistcount = User.find_by_sql("SELECT c.* FROM users c
      inner join PIS_Employee_U a ON c.EmployeeRefNo = a.EmployeeRefNo
      INNER JOIN  PIS_EmploymentInfo_U b ON a.EmployeeRefNo = b.EmployeeRefNo AND b.IsActive = 1
      WHERE b.EmployeeGroupRefNo = 2   
      AND c.email <> 'noemail' AND IsNull(c.IsSend,0) <> 1").count
             
   end


     # mass maill send function = /users/password/resendresetnow
   def resendresetnow

       User.find_by_sql("SELECT c.* FROM users c
      inner join PIS_Employee_U a ON c.EmployeeRefNo = a.EmployeeRefNo
      INNER JOIN  PIS_EmploymentInfo_U b ON a.EmployeeRefNo = b.EmployeeRefNo AND b.IsActive = 1
      WHERE b.EmployeeGroupRefNo = 2   
      AND c.email <> 'noemail' AND IsNull(c.IsSend,0) <> 1").each do |user|
        # This only sends the password reset instructions, the
        # password is not changed. (Recipient has to click link
        # in email and follow instructions to actually change
        # the password).
        user.send_reset_password_instructions
        user.update(IsSend: 1)

        end

        
        flash[:notice] = "Email/s was sent successfully." 
        redirect_to '//users/password/resendreset'
    end




    ## update password
    def user_update_password
      
      #check if newpass and confirmpass are same
      if params[:newPass] == params[:confirmPass]#true
        #check if newpass and confirmpass are empty
        if params[:newPass] != '' || params[:confirmPass] != ''#true
          #check if user was existing on the bank
          get_emp_on_bank= PortalPasswordBank.where(EmployeeRefNo: params[:emprefno]).exists?

          if get_emp_on_bank == true #emp exists
            #check if pass was not existing and over one year
            params_new_pass = params[:newPass]
          
            #get current date
            get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
            current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S') 

            #check if password existing on bank
            emp_rec_bank = PortalPasswordBank.where(EmployeeRefNo:current_user.EmployeeRefNo)

            counter_check = 0
            array_id_collect = []

            emp_rec_bank.each do |emp_rec_bank|
              emp_rec_bank_password_convert = BCrypt::Password.new(emp_rec_bank.Password)

              if emp_rec_bank_password_convert == params_new_pass
                  
                 counter_check = counter_check + 1 
                 array_id_collect << emp_rec_bank.ID

              end 
            end

            if counter_check > 0 #password exists -  check if existing is within one year

                emprec = PortalPasswordBank.find_by_sql("select top 1 * from portal_password_bank where id in (#{array_id_collect.compact.join(',')}) order by DateChanged asc")

                check_within_1yr = ''
                emprec.each do |emprec|
                    get_existing_datechanged_plus_1yr = emprec.DateChanged + 1.year
                    check_within_1yr = current_datetime.between? emprec.DateChanged, get_existing_datechanged_plus_1yr

                end

                if check_within_1yr == true #password was used within 1 year

                  flash[:notice] = 'Cannot use old password.'
                  redirect_to user_edit_password_path  and return

                else #password out side 1year - save new password 
                  #add emp-pass on bank / update users pass
                  get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
                  current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

                  get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: params[:emprefno])
                  get_existing_passbank.update(IsCurrent: false) 

                  get_new_password = encrypted_password_in_database = BCrypt::Password.create(params[:newPass])
             
                  save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: params[:emprefno], Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
                  save_pass_bank.save

                  user = User.find_by(EmployeeRefNo: params[:emprefno])
                  user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

                  flash[:notice] = 'Successfully saved new password, please login again...'
                  redirect_to new_user_session_path and return
                  
                end


            else #password does not exists will create new password

              #add emp-pass on bank / update users pass
              get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
              current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

              get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: params[:emprefno])
              get_existing_passbank.update(IsCurrent: false) 

              get_new_password = encrypted_password_in_database = BCrypt::Password.create(params[:newPass])
         
              save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: params[:emprefno], Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
              save_pass_bank.save

              user = User.find_by(EmployeeRefNo: params[:emprefno])
              user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

              flash[:notice] = 'Successfully saved new password, please login again..'
              redirect_to new_user_session_path and return
              
            end

          else # emp not exists on pass bank
            #add emp-pass on bank / update users pass
            get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
            current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

            get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: params[:emprefno])  
            get_existing_passbank.update(IsCurrent: 0)  

            get_new_password = encrypted_password_in_database = BCrypt::Password.create(params[:newPass])

            save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: params[:emprefno], Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
            save_pass_bank.save

            user = User.find_by(EmployeeRefNo: params[:emprefno])
            user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

            flash[:notice] = 'Successfully saved new password, please login again.'
            redirect_to new_user_session_path and return

          end

        else
          flash[:notice] = 'Please enter New Password / Confirm Password'
          redirect_to user_edit_password_path  and return
        end

      else  
        flash[:notice] = 'New Password and Confirm Password did not matched.'
        redirect_to user_edit_password_path    and return
      end 


    end
    ## end update password



    ## start user_expire_password
    def user_expire_password


    end
    ## end user_expire_password


    ## start user_expire_password
    def user_process_expire_password

      #check if newpass and confirmpass are same
      if params[:newPass] == params[:confirmPass]#true
        #check if newpass and confirmpass are empty
        if params[:newPass] != '' || params[:confirmPass] != ''#true
          #check if user was existing on the bank
          get_emp_on_bank= PortalPasswordBank.where(EmployeeRefNo: params[:emprefno]).exists?

          if get_emp_on_bank == true #emp exists
            #check if pass was not existing and over one year
            params_new_pass = params[:newPass]
          
            #get current date
            get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
            current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S') 

            #check if password existing on bank
            emp_rec_bank = PortalPasswordBank.where(EmployeeRefNo:current_user.EmployeeRefNo)

            counter_check = 0
            array_id_collect = []

            emp_rec_bank.each do |emp_rec_bank|
              emp_rec_bank_password_convert = BCrypt::Password.new(emp_rec_bank.Password)

              if emp_rec_bank_password_convert == params_new_pass
                  
                 counter_check = counter_check + 1 
                 array_id_collect << emp_rec_bank.ID

              end 
            end

            if counter_check > 0 #password exists -  check if existing is within one year

                emprec = PortalPasswordBank.find_by_sql("select top 1 * from portal_password_bank where id in (#{array_id_collect.compact.join(',')}) order by DateChanged asc")

                check_within_1yr = ''
                emprec.each do |emprec|
                       = emprec.DateChanged + 1.year
                    check_within_1yr = current_datetime.between? emprec.DateChanged, get_existing_datechanged_plus_1yr

                end

                if check_within_1yr == true #password was used within 1 year

                  flash[:notice] = 'Cannot use old password.'
                  redirect_to user_expire_password_path  and return

                else #password out side 1year - save new password 
                  #add emp-pass on bank / update users pass
                  get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
                  current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

                  get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: params[:emprefno])
                  get_existing_passbank.update(IsCurrent: false) 

                  get_new_password = encrypted_password_in_database = BCrypt::Password.create(params[:newPass])
             
                  save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: params[:emprefno], Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
                  save_pass_bank.save

                  user = User.find_by(EmployeeRefNo: params[:emprefno])
                  user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

                  flash[:notice] = 'Successfully saved new password, please login again...'
                  redirect_to new_user_session_path and return
                  
                end


            else #password does not exists will create new password

              #add emp-pass on bank / update users pass
              get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
              current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

              get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: params[:emprefno])
              get_existing_passbank.update(IsCurrent: false) 

              get_new_password = encrypted_password_in_database = BCrypt::Password.create(params[:newPass])
         
              save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: params[:emprefno], Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
              save_pass_bank.save

              user = User.find_by(EmployeeRefNo: params[:emprefno])
              user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

              flash[:notice] = 'Successfully saved new password, please login again..'
              redirect_to new_user_session_path and return
              
            end

          else # emp not exists on pass bank
            #add emp-pass on bank / update users pass
            get_utc = ActiveRecord::Base.connection.exec_query("select utc_plus_8 = CAST(DATEADD(HOUR,8,GETUTCDATE()) AS datetime);")
            current_datetime = get_utc.rows[0][0].to_time.strftime('%Y-%m-%d %H:%M:%S')

            get_existing_passbank = PortalPasswordBank.where(EmployeeRefNo: params[:emprefno])  
            get_existing_passbank.update(IsCurrent: 0)  

            get_new_password = encrypted_password_in_database = BCrypt::Password.create(params[:newPass])

            save_pass_bank = PortalPasswordBank.create(EmployeeRefNo: params[:emprefno], Password: get_new_password, DateChanged: current_datetime, IsCurrent: true )
            save_pass_bank.save

            user = User.find_by(EmployeeRefNo: params[:emprefno])
            user.update(encrypted_password: get_new_password, updated_at: current_datetime, PasswordCreatedDate: current_datetime)

            flash[:notice] = 'Successfully saved new password, please login again.'
            redirect_to new_user_session_path and return

          end

        else
          flash[:notice] = 'Please enter New Password / Confirm Password'
          redirect_to user_expire_password_path  and return
        end

      else  
        flash[:notice] = 'New Password and Confirm Password did not matched.'
        redirect_to user_expire_password_path    and return
      end 

    end
    ## end user_expire_password



  protected
    def after_resetting_password_path_for(resource)
      Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    # Check if a reset_password_token is provided in the request
    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        set_flash_message(:alert, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end

    # Check if proper Lockable module methods are present & unlock strategy
    # allows to unlock resource on password reset
    def unlockable?(resource)
      resource.respond_to?(:unlock_access!) &&
        resource.respond_to?(:unlock_strategy_enabled?) &&
        resource.unlock_strategy_enabled?(:email)
    end

    def translation_scope
      'devise.passwords'
    end




    private
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new
        resource.validate # Look for any other validation errors besides Recaptcha
        set_minimum_password_length
        respond_with resource
      end 
    end


    private

    def adminchecker
       
        if current_user.blank?
          redirect_to '/'
        else
          userrefno1 = current_user.EmployeeRefNo
          checkifadmin = User.where(EmployeeRefNo: userrefno1).pluck(:IsAdmin).to_sentence
          if checkifadmin == 'true'
            #flash[:notice] = "Admininstrator Logged-In"
          else
            redirect_to '/' 
          end  
        end 
    end


    private
    def checkadminloggedin

      if user_signed_in? == false
        @getuserrefno110 = 0
      else
        getuserrefno110 = current_user.EmployeeRefNo
        getuserrefnoforbday = getuserrefno110
        @getuserrefno110 = User.where(EmployeeRefNo:getuserrefno110).pluck(:IsAdmin).to_sentence
      end 

    end


end
