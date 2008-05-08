class Admin::TroopsController < Admin::AdminController
  active_scaffold :troop do |config|
    config.actions = [:list, :create, :update, :delete]
  end
end
