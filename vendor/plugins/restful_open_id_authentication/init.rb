begin
  require 'openid'
rescue LoadError
  puts "Install the ruby-openid gem to enable OpenID support"
end
require 'open_id_store'
require 'controller_methods'

class << ActionController::Base
  def open_id_consumer(options = {})
    include OpenIdConsumer::ControllerMethods
    self.open_id_consumer_options = options
  end
end
