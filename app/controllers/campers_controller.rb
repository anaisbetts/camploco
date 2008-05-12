class CampersController < ApplicationController
  before_filter :login_required
  resources_controller_for :campers, :in => :troop
end
