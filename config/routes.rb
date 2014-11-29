Rails.application.routes.draw do

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users, only: [:index, :create, :edit, :destroy, :update]
  end

  get '/admin/change_users/:id', to: 'admin/users#change_user'

  root to: 'movies#index'


end
