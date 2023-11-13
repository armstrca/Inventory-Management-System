#/workspaces/Inventory-Management-System/config/routes.rb
Rails.application.routes.draw do
  resources :subcategories
  root "users#index"
  devise_for :users
  devise_scope :user do
    get "users/admin_new" => "users#admin_new"
    post "users/admin_create" => "users#admin_create"
  end
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
  # post "users/check_email_availability", to: "users#check_email_availability"
  get "search", to: "search#index"
end
