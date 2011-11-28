FirstApp::Application.routes.draw do

  resources :authentications, :only => [:index, :create, :detroy]

  resources :comments, :only => [:create, :destroy]
  
  resources :favorites, :only => [:create, :destroy] do
    collection do
      get 'my_favorites'
    end
  end
  
  resources :proposals do
    member do
      post 'accept'
      post 'reject'
    end
    collection do
      get 'my_proposals'
      get 'proposals_to_me'
    end
  end
  
  resources :posts do
    collection do
      get 'my_posts'
    end
    #/posts/:id/likeships.json
    resources :likeships, :only => [:index]
    #/posts/:id/comments.json
    resources :comments, :only => [:index]
    #/posts/:id/favorites.json
    resources :favorites, :only => [:index]
  end
  
  match "feed_timeline" => "posts#feed_posts_timeline"
  match "auth/:provider/callback" => "authentications#create" 

  resources :followships, :only => [:create, :destroy]
  
  resources :likeships, :only => [:create, :destroy]
  
  #devise_for :users, :path_names => {:sign_up => "register"}
  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations" }, :path_names => {:sign_up => "register"}
  
  match "profile" => "users#show"
  match "list"    => "users#index"
  
  resources :contacts

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'users#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
