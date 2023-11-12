#/workspaces/Inventory-Management-System/config/routes.rb
Rails.application.routes.draw do
  resources :subcategories
  root "users#index"
  devise_for :users
  resources :users
  resources :reports
  resources :storage_locations
  resources :roles
  resources :inventory_transactions
  resources :order_items
  resources :orders
  resources :suppliers
  resources :categories
  resources :products
  post "users/check_email_availability", to: "users#check_email_availability"
  get "search", to: "search#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
