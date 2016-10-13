Rails.application.routes.draw do

  get '/auth/spotify/callback', to: 'users#spotify'
  root 'events#index'
  post '/logout' => "users#logout"
  resources :users

  resources :events do
    get 'rsvp', on: :member
    get 'guests', on: :member
    get 'playlist', on: :member
  end
end
