class SessionsController < ApplicationController
  include AuthenticatedSystem
  def create
    open_id_authentication
  end

  def show
    # TODO: Figure out how to redirect to where we were previously
    #redirect_to :controller => "troops", :action => "show"
    #debugger
  end

  def open_id_authentication
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        if @current_user = User.find_by_identity_url(identity_url)
          successful_login
        else
          # Auto-create the new user
          new_user = User.new
          new_user.identity_url = identity_url
          new_user.save
          @current_user = User.find_by_identity_url(identity_url)
          #redirect_to("http://www.google.com")

          successful_login
        end
      else
        #redirect_to("http://www.yahoo.com")
        failed_login result.message
      end
    end
  end


  private
  def successful_login
    session[:user_id] = @current_user.id
    #redirect_to("http://www.msn.com")
    #debugger
    redirect_to(root_url)
  end

  def failed_login(message)
    flash[:error] = message
    #redirect_to("http://www.slashdot.org")
    foo = "test"
    #debugger
    redirect_to(new_session_url)
  end
end
