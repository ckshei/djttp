require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "a8a0f594654c40aa93e0d1086567c57a", "b5128b5355f941338a9c6295aaf30aeb", scope: 'user-top-read user-read-email playlist-modify-public user-read-birthdate user-read-private'
end
