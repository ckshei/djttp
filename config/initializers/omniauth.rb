require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'], scope: 'user-top-read user-read-email playlist-modify-public user-read-birthdate user-read-private'
end
