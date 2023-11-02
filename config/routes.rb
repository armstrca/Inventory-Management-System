Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  resources :users
  resources :reports
  resources :locations
  resources :roles
  resources :inventory_transactions
  resources :order_items
  resources :orders
  resources :suppliers
  resources :categories
  resources :products
  post 'users/check_email_availability', to: 'users#check_email_availability'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
