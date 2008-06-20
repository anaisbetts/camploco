ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  #  map.admin 'admin', :controller => 'admin/admin'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:id', :controller => 'accounts', :action => 'show'
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'
  map.change_password '/change_password', :controller => 'accounts', :action => 'edit'
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :requirements => { :method => :get }

  map.resources :users, :member => { :enable => :put } do |users|
    users.resource :account
    users.resources :roles
  end

  map.resource :session
  map.resource :password

  map.namespace :admin do |admin|
    admin.resources :counselors, :active_scaffold => true
    admin.resources :campers, :active_scaffold => true
    admin.resources :troops, :active_scaffold => true
    admin.resources :users, :active_scaffold => true
  end

  map.namespace :reports do |reports|
    reports.connect 'attendance', :controller => 'attendance', :action => 'index'
    reports.connect 'completion', :controller => 'completion', :action => 'index'
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  map.resources :troops do |troop|
    troop.resources :campers
  end

  map.connect '/campers/:action', :controller => 'campers'

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
