class WelcomeController < ApplicationController
  def index
    redirect_to :controller => 'troops'
  end
end
