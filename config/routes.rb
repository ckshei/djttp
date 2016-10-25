Rails.application.routes.draw do

  get '/auth/spotify/callback', to: 'users#spotify'
  root 'events#index'
  post '/logout' => "users#logout"
  resources :users

  resources :events do
    get 'sync', on: :member
    get 'guests', on: :member
    get 'playlist', on: :member
    get 'refresh_playlist', on: :member
  end
end
