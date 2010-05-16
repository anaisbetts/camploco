class CampersController < ApplicationController
  before_filter :login_required
  resources_controller_for :campers, :in => :troop
  skip_before_filter :load_enclosing_resources, :only => :disable_sessions

  def disable_sessions
    # Set the MB stuff so we can get the enabled sessions
    fake = Camper.new

    c = params["camper"]
    fake.meritbadge0_text = c["meritbadge0_text"]
    fake.meritbadge1_text = c["meritbadge1_text"]
    fake.meritbadge2_text = c["meritbadge2_text"]
    fake.meritbadge3_text = c["meritbadge3_text"]

    @enabled_list = (0..3).collect {|x| fake.slot_enabled? x}

    respond_to do |wants|
      wants.js
    end
  end
end
