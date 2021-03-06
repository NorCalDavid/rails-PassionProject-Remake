Rails.application.routes.draw do

  root 'homepage#index'

  get  'login'  => 'sessions#new', as: :login
  post 'login'  => 'sessions#create'
  get 'logout'  => 'sessions#destroy', as: :logout
  get 'google/oauth' => 'google#oauth'
  get 'google/oauth/redirect' => 'google#token'

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
