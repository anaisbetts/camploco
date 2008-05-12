class TroopsController < ApplicationController
  before_filter :login_required
  after_filter :hack_in_user_id

  resources_controller_for :troops

  def hack_in_user_id
    return unless ['update', 'create'].include? action_name
    @troop.user_id = session[:user_id]
    @troop.save
  end
end
