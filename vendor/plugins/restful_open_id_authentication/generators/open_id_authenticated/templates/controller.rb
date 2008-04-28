# This controller handles the login/logout function of the site.  
class <%= controller_class_name %>Controller < ApplicationController
  open_id_consumer :required => [:email, :nickname]
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # render new.rhtml
  def new
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
  end

  def create
    self.current_<%= file_name %> = <%= class_name %>.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_<%= file_name %>.remember_me
        cookies[:auth_token] = { :value => self.current_<%= file_name %>.remember_token , :expires => self.current_<%= file_name %>.remember_token_expires_at }
      end
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      flash[:notice] = "Login failed"
      render :action => 'new'
    end
  end

  def destroy
    self.current_<%= file_name %>.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
  def begin
    # If the URL was unusable (either because of network conditions, a server error, 
    # or that the response returned was not an OpenID identity page), the library 
    # will return HTTP_FAILURE or PARSE_ERROR. Let the user know that the URL is unusable.
    case open_id_response.status
      when OpenID::SUCCESS
        # The URL was a valid identity URL. Now we just need to send a redirect
        # to the server using the redirect_url the library created for us.

        # redirect to the server
        redirect_to open_id_response.redirect_url((request.protocol + request.host_with_port + "/"), complete_<%= controller_file_name %>_url)
      else
        flash[:error] = "Unable to find OpenID server for <q>#{params[:open_id_url]}</q>"
        render :action => :new
    end
  end
  
  def complete
    case open_id_response.status
      when OpenID::FAILURE
        # In the case of failure, if info is non-nil, it is the URL that we were verifying. 
        # We include it in the error message to help the user figure out what happened.
        flash[:notice] = if open_id_response.identity_url
          "Verification of #{open_id_response.identity_url} failed. "
        else
          "Verification failed. "
        end
        flash[:notice] += open_id_response.msg.to_s
      when OpenID::SUCCESS
        # Success means that the transaction completed without error. If info is nil, 
        # it means that the user cancelled the verification.
        flash[:notice] = "You have successfully verified #{open_id_response.identity_url} as your identity."
        if open_id_fields.any?
          @<%= file_name %>   = <%= class_name %>.find_by_open_id_url(open_id_response.identity_url)
          @<%= file_name %> ||= <%= class_name %>.new(:open_id_url => open_id_response.identity_url)
          @<%= file_name %>.login       = open_id_fields['nickname'] if open_id_fields['nickname']
          @<%= file_name %>.email       = open_id_fields['email']    if open_id_fields['email']          
          if @<%= file_name %>.save
            self.current_<%= file_name %> = @<%= file_name %>
            if params[:remember_me] == "1"
              self.current_<%= file_name %>.remember_me
              cookies[:auth_token] = { :value => self.current_<%= file_name %>.remember_token , :expires => self.current_<%= file_name %>.remember_token_expires_at }
            end
            flash[:notice] = "You have successfully verified #{open_id_response.identity_url} as your identity."
            return redirect_back_or_default('/')
          else
            flash[:notice] = @<%= file_name %>.errors.full_messages.join('<br />')
            render :action => 'new' and return
          end
        end
      when OpenID::CANCEL
        flash[:notice] = "Verification cancelled."
      else
        flash[:notice] = "Unknown response status: #{open_id_response.status}"
    end
    redirect_to :action => 'new'
  end
end
