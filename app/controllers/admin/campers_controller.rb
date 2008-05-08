class Admin::CampersController < Admin::AdminController
  active_scaffold :camper do |config|
    config.actions = [:list, :create, :update, :delete]
  end
end
