Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'

  root 'static_pages#home'

  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'microposts_feed', to: 'microposts#show'

  resources :users do
    member do
      get :following, :followers
    end
    collection do
      get :auto_complete
    end
  end

  namespace :api, format: :json do
    namespace :v1 do
      resources :users
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :rooms, only: %i[index show create]

  mount ActionCable.server => '/cable'
end
