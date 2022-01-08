# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :events
  get 'events/page/(:page(.:format))', to: 'events#index'
  get 'stats', to: 'stats#index'
  # get 'calendar', to: 'calendar#index', as: 'calendar_index'
  # get 'about', to: 'abount#index', as: 'about_index'
end
