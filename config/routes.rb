#/workspaces/Inventory-Management-System/config/routes.rb
Rails.application.routes.draw do
  resources :subcategories
  root "users#index"
  devise_for :users
  # resources :users do
  #   collection do
  #     get "admin_new"
  #     post "admin_create"
  #   end
  # end
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



# devise_scope :user do
#   get "users/sign_up", to: "devise/registrations#new", as: :new_user_registration
#   post "users", to: "devise/registrations#create", as: :user_registration
#   get "users/edit", to: "devise/registrations#edit", as: :edit_user_registration
#   patch "users", to: "devise/registrations#update"
#   put "users", to: "devise/registrations#update"
#   delete "users", to: "devise/registrations#destroy"
#   get  'users/new', to: 'users#new'
#   post 'users/create', to: 'users#create'
#   get "users/sign_in", to: "devise/sessions#new", as: :new_user_session
#   post "users/sign_in", to: "devise/sessions#create", as: :user_session
#   delete "users/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session

#   get "users/password/new", to: "devise/passwords#new", as: :new_user_password
#   get "users/password/edit", to: "devise/passwords#edit", as: :edit_user_password
#   patch "users/password", to: "devise/passwords#update"
#   put "users/password", to: "devise/passwords#update"
#   post "users/password", to: "devise/passwords#create"

#   get "users/cancel", to: "devise/registrations#cancel", as: :cancel_user_registration
# end
