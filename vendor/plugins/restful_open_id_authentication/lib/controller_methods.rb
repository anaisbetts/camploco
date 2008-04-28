module OpenIdConsumer
  module ControllerMethods
    def self.included(controller)
      controller.class_eval do
        verify :method => :post, :only => :begin, :params => :open_id_url, :redirect_to => { :action => 'index' },
          :add_flash => { :error => "Enter an Identity URL to verify." }
        verify :method => :get, :only => :complete, :redirect_to => { :action => 'index' }
        before_filter  :begin_open_id_auth,    :only => :begin
        before_filter  :complete_open_id_auth, :only => :complete
        attr_reader    :open_id_response
        attr_reader    :open_id_fields
        cattr_accessor :open_id_consumer_options
      end
    end

    protected
    
      def open_id_consumer
        @open_id_consumer ||= OpenID::Consumer.new(
          session[:open_id_session] ||= {}, 
          OpenIdStore.new)
      end

      def begin_open_id_auth
        @open_id_response = open_id_consumer.begin(params[:open_id_url])
        add_sreg_params!(@open_id_response) if @open_id_response.status == OpenID::SUCCESS
      end

      def complete_open_id_auth
        @open_id_response = open_id_consumer.complete(params)
        return unless open_id_response.status == OpenID::SUCCESS

        @open_id_fields   = open_id_response.extension_response('sreg')
        logger.debug "***************** sreg params ***************"
        logger.debug @open_id_fields.inspect
        logger.debug "***************** sreg params ***************"
      end
      
      
      def authenticate_with_open_id(identity_url)
        @open_id_response = open_id_consumer.begin(identity_url)
        yield(@open_id_response.status.to_sum)
        
        # If the URL was unusable (either because of network conditions, a server error, 
        # or that the response returned was not an OpenID identity page), the library 
        # will return HTTP_FAILURE or PARSE_ERROR. Let the user know that the URL is unusable.
        case open_id_response.status
          when OpenID::SUCCESS
            add_sreg_params!(@open_id_response)
            redirect_to open_id_response.redirect_url((request.protocol + request.host_with_port + "/"), complete_session_url)
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
              @user   = User.find_by_open_id_url(open_id_response.identity_url)
              @user ||= User.new(:open_id_url => open_id_response.identity_url)
              @user.login       = open_id_fields['nickname'] if open_id_fields['nickname']
              @user.email       = open_id_fields['email']    if open_id_fields['email']          
              if @user.save
                self.current_user = @user
                if params[:remember_me] == "1"
                  self.current_user.remember_me
                  cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
                end
                flash[:notice] = "You have successfully verified #{open_id_response.identity_url} as your identity."
                return redirect_back_or_default('/')
              else
                flash[:notice] = @user.errors.full_messages.join('<br />')
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
      
      
      def authenticate_with_open_id(identity_url)
        
        
        case status
        when :missing
          failed_authentication "Sorry, the OpenID server couldn't be found"
 
        when :canceled
          failed_authentication "OpenID verification was canceled"
 
        when :failed
          failed_authentication "Sorry, the OpenID verification failed"
 
        when :successful
          if @current_user =
              @account.users.find_by_identity_url(identity_url)
            successful_authentication
          else
            failed_authentication "Sorry, no user by that identity URL exists"
          end
        end
      end
      
      

      def add_sreg_params!(openid_response)
        open_id_consumer_options.keys.inject({}) do |params, key|
          value = open_id_consumer_options[key]
          value = value.collect { |v| v.to_s.strip } * ',' if value.respond_to?(:collect)
          openid_response.add_extension_arg('sreg', key.to_s, value.to_s)
        end
      end
  end
end