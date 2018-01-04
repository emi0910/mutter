Rails.application.routes.draw do
  root 'welcome#index'
  get  '/home',   to: 'welcome#index'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users, :except => [:new]

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
