Rails.application.routes.draw do
  root 'bands#index'
  get '/signup(/:invite_token)' => "users#new", as: :signup
  get '/login'  => "sessions#new", as: :login
  post '/login' => "sessions#create", as: :login_create
  get '/logout' => "sessions#destroy", as: :logout

  resources :users, except: [:index, :show]
  resources :bands, except: [:show] do
    resources :invites, only: [:new, :create]
    resources :memberships, only: [:destroy]
    resources :songs do
      resources :comments, only: [:create]
    end
  end
end
