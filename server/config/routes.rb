Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  post '/auth/login', to: 'auth#create'
  put '/users', to: 'users#update'
  resources :articles
  resources :users, except: [:new]
  resources :comments, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :followers, only: [:create, :destroy]
  resources :followings, only: [:create, :destroy]
end