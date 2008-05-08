class Admin::AdminController < ApplicationController
  def index
    render :template => 'layouts/admin', :layout => false
  end
end
