Merch::Application.routes.draw do
  devise_for :users

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
  
  namespace :api do
    resources :products
  end
  
  match '/search' => 'search#index'
  
  namespace :user do
    root :to => "admin#index"
  end
  match '/admin' => 'admin#index'
  
  resources :games do
    get 'find', :on => :collection
    get 'add',  :on => :member
  end
  resources :developers, :merchants
  resources :series, :controller => 'franchises', :as => 'franchises'
  resources :categories, :controller => 'product_types', :as => 'product_types'
  
  resource :amazon_api do
    resources :junctions
  end
  
  match '/search' => 'search#index'
  
  resources :products
  
  root :to => 'welcome#index'
  
  #resources :products, :path => '/'
  
  # match '/:id' => 'products#show', :as => 'short_product', :via => 'get'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"
end
