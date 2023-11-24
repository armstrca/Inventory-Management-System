#/workspaces/Inventory-Management-System/config/routes.rb
Rails.application.routes.draw do
  root "products#index"
  get '/forgot_password', to: 'users#forgot_password'
  devise_for :users, :controllers => { :registrations => "custom_devise/registrations" }
  resources :users
  resources :storage_locations
  resources :roles
  resources :inventory_transactions
  resources :order_items
  get '/orders/incoming', to: 'orders#incoming'
  get '/orders/outgoing', to: 'orders#outgoing'
  resources :orders
  resources :suppliers
  resources :categories
  resources :products
  resources :subcategories
  get "search", to: "search#index"
  get "/subcategories_by_category", to: "products#subcategories_by_category"

  # match "*path", to: "errors#not_found", via: :all
  # get 'errors/not_found'
  # get 'errors/internal_server_error'
end
