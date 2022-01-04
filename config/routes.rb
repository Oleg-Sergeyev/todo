Rails.application.routes.draw do
  resources :events
  get 'events/page/(:page(.:format))', to: 'events#index'
  get 'stats', to: 'stats#index'
  #get 'calendar', to: 'calendar#index', as: 'calendar_index'
  #get 'about', to: 'abount#index', as: 'about_index'
end
