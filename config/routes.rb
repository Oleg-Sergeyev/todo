Rails.application.routes.draw do
  get 'stats', to: 'stats#index'
  #get 'about', to: 'abount#index', as: 'about_index'
end
