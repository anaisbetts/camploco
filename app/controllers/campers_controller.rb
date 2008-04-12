class CampersController < ApplicationController
  before_filter :set_troop

  resources_controller_for :campers

  def set_troop
    @troop = Troop.find_by_id(params[:troop_id])
  end
end
