Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  resources :users, except: [:new]
  resources :comments, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
end