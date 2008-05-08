class Admin::UsersController < Admin::AdminController
  active_scaffold :user do |config|
    config.actions = [:list, :create, :update, :delete]
  end
end
