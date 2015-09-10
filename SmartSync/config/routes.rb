Rails.application.routes.draw do

  root 'homepage#index'

  get  'login'  => 'sessions#new', as: :login
  post 'login'  => 'sessions#create'
  get 'logout'  => 'sessions#destroy', as: :logout
  get 'oauth' => 'google#oauth'
  get 'oauth/redirect' => 'google#token'
  get 'oauth/profile/update' => 'google#profile_edit', as: :oauth_update_profile
  post 'oauth/profile' => 'google#profile_update'

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
