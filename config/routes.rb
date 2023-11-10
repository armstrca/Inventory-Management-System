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
  get 'orders/incoming', to: 'orders#incoming', as: 'incoming_orders'
  get 'orders/outgoing', to: 'orders#outgoing', as: 'outgoing_orders'
  resources :orders
  resources :suppliers
  resources :categories
  resources :products
  post 'users/check_email_availability', to: 'users#check_email_availability'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
