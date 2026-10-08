# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
 prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  prepend_before_action :set_minimum_password_length, only: [:edit]
  prepend_before_action :checker_oldpass, only: [:edit, :index,:new] # Change this to be any actions you want to protect.
   prepend_before_action :checkadminloggedin

  # GET /resource/sign_up
  def new
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    getemployeenumentered1= User.last
    getemployeenumentered = getemployeenumentered1[:EmployeeNumber]

     getresultempnum = PisEmployeeU.where(EmployeeNumber: getemployeenumentered).pluck(:EmployeeNumber)  

     if getresultempnum.blank?
        gettobedestroy1= User.last
        gettobedestroy = gettobedestroy1[:id]
        User.destroy(gettobedestroy)
        redirect_to "/users/sign_up", :alert => "Employee Number, does not exist!"

     else
        getlastuserid1 = User.last
        getlastuserid = getlastuserid1[:id]
        
        getempemail = PisEmployeeU.where(EmployeeNumber: getemployeenumentered).pluck(:PersonalEmailAddress).to_sentence        
        getempfname = PisEmployeeU.where(EmployeeNumber: getemployeenumentered).pluck(:FirstName).to_sentence
        getempmname = PisEmployeeU.where(EmployeeNumber: getemployeenumentered).pluck(:MiddleName).to_sentence
        getemplname = PisEmployeeU.where(EmployeeNumber: getemployeenumentered).pluck(:LastName).to_sentence
        getpassword = "IPI"#getempfname[0]+getempmname[0]+getemplname[0]
        getempfullname = PisEmployeeU.where(EmployeeNumber: getemployeenumentered).pluck(:FullName).to_sentence
        getemprefno1 = PisEmployeeU.where(EmployeeNumber: getemployeenumentered).pluck(:EmployeeRefno).to_sentence
        getemprefno = getemprefno1.to_i
        User.update(getlastuserid,:email => "finding.ned222705@gmail.com", :password => "#{getpassword}", :username => "#{getempfullname}", :EmployeeRefNo => "#{getemprefno}" )

        redirect_to "/", :alert => "Employee Registered!"

     end


  end

  # GET /resource/edit
  def edit
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      redirect_to "/portal/users/sign_in", :alert => "Password Changed, you need to sign in before continuing."
      #respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource) if is_navigational_format?
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    sign_in_after_change_password? #signed_in_root_path(resource) : new_session_path(resource_name)
    #sign_out current_user
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
    
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def translation_scope
    'devise.registrations'
  end

  private

  def set_flash_message_for_update(resource, prev_unconfirmed_email)
    return unless is_flashing_format?

    flash_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                  :update_needs_confirmation
                elsif sign_in_after_change_password?
                  :updated
                else
                  :updated_but_not_signed_in
                end
    set_flash_message :notice, flash_key
  end

  def sign_in_after_change_password?
    return true if account_update_params[:password].blank?

    #Devise.sign_in_after_change_password
    sign_out current_user
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
        #redirect_to 'destroy_user_session_path'
        redirect_to '/users/password/new' and return
        #redirect_to :controller => 'users/sessions', :action => 'destroy', :method => 'DELETE'
        #redirect_back fallback_location: "http://www.rubyonrails.org"
      else
        flash[:success] = "Welcome!"  
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
