# frozen_string_literal: true

Rails.application.routes.draw do
  
  namespace :admin do
    resources :roles
  end
  namespace :admin do
    root 'users#index'
    resources :users
  end
  root 'home#index'
  #devise_for :users
  devise_for :users #, :path_prefix => 'admin'
  match 'users/:id' => 'admin/users#destroy', via: :delete, as: :admin_destroy_user
  match 'users/:id' => 'admin/users#create', via: :create, as: :admin_create_user
  resources :users

  match 'roles/:id' => 'admin/roles#destroy', via: :delete, as: :admin_destroy_role
  match 'roles/:id' => 'admin/roles#create', via: :create, as: :admin_create_role
  resources :roles
  # devise_for :user, path_names: {
  #   sign_in: 'login', sign_out: 'logout'
  # }
  resources :events do
    resources :items
  end
  resources :events
  # get 'events/page/(:page(.:format))', to: 'events#index'
  #get 'events/page', to: 'events#index'
  get 'stats', to: 'stats#index'
  get 'about', to: 'about#index'
  # get 'calendar', to: 'calendar#index', as: 'calendar_index'
  # get 'about', to: 'abount#index', as: 'about_index'
end
