class TroopsController < ApplicationController
  before_filter :login_required
  after_filter :hack_in_user_id

  resources_controller_for :troops

  def hack_in_user_id
    return unless ['update', 'create'].include? action_name
    @troop.user_id = session[:user_id]
    @troop.save
  end

  def destroy 
    troop = find_resource
    troop.hidden = true
    troop.save
    respond_to do |format|
      format.html do
        flash[:notice] = "#{resource_name.humanize} was successfully deleted. Please Email the camp director if this was incorrect"
        redirect_to resources_url
      end
      format.js
      format.xml  { head :ok }
    end
  end
end
