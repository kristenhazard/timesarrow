ActionController::Routing::Routes.draw do |map|
  map.resources :item_statuses

  map.resources :item_statuses

  map.resources :item_statuses

  map.resources :statuses

  map.resources :statuses

  map.resources :categories

  map.resources :user_sessions

  map.resources :users

  map.resources :timeline_items,
                :member => { :popup => :get, :re_sort => :post },
                :collection => { :sort => :post }

  map.resources :timelines, 
                :member => { :select_item => :post }, 
                :collection => { :featured => :get, :makeone => :get, :books => :get }

  map.resources :items, 
                :member => { :select_item => :post }
                
  map.resources :sessions
  
  map.resources :search
                
  map.home '', :controller => 'timelines', :action => 'featured'
  
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.filtered_cat 'timelines/:category', :controller => 'timelines', :action => 'filtered'
  map.filtered_cat_sub 'timelines/:category/:subcategory', :controller => 'timelines', :action => 'filtered'
  map.filtered_cat_sub_genre 'timelines/:category/:subcategory/:genre', :controller => 'timelines', :action => 'filtered'
  map.filtered_genre 'timelines/:genre', :controller => 'timelines', :action => 'filtered'
  

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
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "timelines", :action => "featured"
  

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
