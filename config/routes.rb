#/workspaces/Inventory-Management-System/config/routes.rb
Rails.application.routes.draw do
  root "products#index"
  devise_for :users, :controllers => { :registrations => "custom_devise/registrations" }
  resources :users
  resources :storage_locations
  resources :roles
  resources :inventory_transactions
  resources :order_items
  resources :orders
  resources :suppliers
  resources :categories
  resources :products
  resources :subcategories
  get "search", to: "search#index"
  get "/subcategories_by_category", to: "products#subcategories_by_category"
end
