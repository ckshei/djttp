Rails.application.routes.draw do

  get '/auth/spotify/callback', to: 'users#spotify'
  root 'users#new'
  get '/welcome' => 'users#home' 
  post '/login' => "users#login"
  post '/logout' => "users#logout"
  resources :users
  resources :events do
    get 'rsvp', on: :member
  end
end
