Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'homepage#index'

  get  'login'  => 'sessions#new', as: :login
  post 'login'  => 'sessions#create'
  get 'logout'  => 'sessions#destroy', as: :logout
  # get 'oauth' => 'google#oauth'
  # get 'oauth/redirect' => 'google#token'
  # get 'oauth/profile/update' => 'google#profile_edit', as: :oauth_update_profile
  # post 'oauth/profile' => 'google#profile_update'

  get 'auth/:provider/callback', to: 'sessions#oauth', as: :oauth
  get 'auth/failure', to: redirect('/')

  resources :sessions, only: [:oauth, :new, :create, :destroy]

  resources :users do

    member do
      get 'homes'
      get 'rooms'
      get 'devices'
    end

  end

  resources :homes do
    resources :rooms do
      resources :devices
    end
  end
end
