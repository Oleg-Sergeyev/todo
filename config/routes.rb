# frozen_string_literal: true

Rails.application.routes.draw do
  
  root 'home#index'
  #devise_for :users
  devise_for :users #, :path_prefix => 'my'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users 
  # devise_for :user, path_names: {
  #   sign_in: 'login', sign_out: 'logout'
  # }
  resources :events
  #resources :users
  # get 'events/page/(:page(.:format))', to: 'events#index'
  get 'events/page', to: 'events#index'
  get 'stats', to: 'stats#index'
  # get 'calendar', to: 'calendar#index', as: 'calendar_index'
  # get 'about', to: 'abount#index', as: 'about_index'
end
