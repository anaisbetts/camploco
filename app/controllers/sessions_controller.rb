class SessionsController < ApplicationController
  layout 'application'
  before_filter :login_required, :only => :destroy
  before_filter :not_logged_in_required, :only => [:new, :create]
  
  # render new.rhtml
  def new
  end
 
  def create
    if using_open_id?
      open_id_authentication(params[:openid_url])
    else  
      password_authentication(params[:login], params[:password])
    end  
  end
 
  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to login_path
    #redirect_back_or_default('/')
  end
  
  protected
  
  def open_id_authentication(openid_url)
    authenticate_with_open_id(openid_url) do |result, identity_url, registration|
      if result.successful?
        @user = User.find_or_initialize_by_identity_url(identity_url)
        if @user.new_record?
          logger.info registration.to_yaml
          @user.login = registration['nickname'] || identity_url
          @user.email = registration['email']
          create_open_id_user(@user)
          self.current_user = @user
          successful_login
        else
          if @user.enabled == false
            failed_login("Your account has been disabled.")
          else
            self.current_user = @user
            successful_login
          end        
        end
      else
        failed_login result.message
      end
    end
  end
  
  def create_open_id_user(user)
    user.save!
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "Someone has signed up with that nickname or email address. Please create
                             another persona for this site."
    render :action => 'new'
  end    
 
  def password_authentication(login, password)
    user = User.authenticate(login, password)
    if user == nil
      failed_login("Your username or password is incorrect.")
    elsif user.enabled == false
      failed_login("Your account has been disabled.")
    else
      self.current_user = user
      successful_login
    end
  end
  
  private
  
  def failed_login(message)
    flash.now[:error] = message
    render :action => 'new'
  end
  
  def successful_login
    if params[:remember_me] == "1"
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
    end
      flash[:notice] = "Logged in successfully"
      return_to = session[:return_to]
      if return_to.nil?
        redirect_to '/'
      else
        redirect_to return_to
      end
  end
 
end

