Rails.application.routes.draw do
  root "profiles#index"
  devise_for :users
  resources :profiles
  resources :reports
  resources :locations
  resources :roles
  resources :inventory_transactions
  resources :order_items
  resources :orders
  resources :suppliers
  resources :categories
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
