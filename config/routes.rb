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

  map.namespace :admin do |admin|
    # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
    admin.resources :counselors, :active_scaffold => true
    admin.resources :campers, :active_scaffold => true
    admin.resources :troops, :active_scaffold => true
    admin.resources :users, :active_scaffold => true
  end

  map.namespace :reports do |reports|
    reports.connect 'attendance', :controller => 'attendance', :action => 'index'
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  map.resources :troops do |troop|
    troop.resources :campers
  end


  map.resources :users

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login',  :controller => 'session', :action => 'new'
  map.logout '/logout', :controller => 'session', :action => 'destroy'

  map.connect '/campers/:action', :controller => 'campers'

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
