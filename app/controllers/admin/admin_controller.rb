class Admin::AdminController < ApplicationController
  before_filter :login_required

  def index
    render :template => 'layouts/admin', :layout => false
  end
end
