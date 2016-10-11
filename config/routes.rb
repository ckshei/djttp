Rails.application.routes.draw do

  get '/auth/spotify/callback', to: 'users#spotify'
  root 'users#new'
  get '/welcome' => 'users#home' 
  resources :users do
    resources :songs, only: [:index, :new]
  end
  post '/login' => "users#login"
  post '/logout' => "users#logout"
  resources :songs, only: [:create]
  resources :events do
    get 'guest', on: :member
    get 'refresh_playlist', on: :member
  end
end
