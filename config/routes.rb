Rails.application.routes.draw do
  root 'welcome#index'
  get  '/home',   to: 'welcome#index'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/articles/preview', to: 'articles#preview'
  resources :users, :except => [:new]
  resources :articles
  resources :user_infos, :only => [:create, :update]
  resources :categories
  resources :images, :only => [:index, :create, :destroy]

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
