class Admin::CounselorsController < Admin::AdminController
  active_scaffold :counselor do |config|
    config.actions = [:list, :create, :update, :delete]
  end
end
