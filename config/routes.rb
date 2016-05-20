Rails.application.routes.draw do
  root 'bands#index'
  get '/signup(/:invite_token)' => "users#new", as: :signup
  get '/login'  => "sessions#new", as: :login
  post '/login' => "sessions#create", as: :login_create
  get '/logout' => "sessions#destroy", as: :logout

  resources :users, except: [:index]
  resources :bands, except: [:show] do
    resources :invites
    resources :memberships, only: [:new, :create, :destroy]
    resources :songs do
      resources :attachments, only: [:new, :create]
      resources :comments, only: [:create]
    end
  end
end
