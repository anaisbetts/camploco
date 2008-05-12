class TroopsController < ApplicationController
  before_filter :login_required

  resources_controller_for :troops
end
