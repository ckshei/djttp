  puts ENV['SPOTIFY_ID']
  puts ENV['SPOTIFY_KEY']
  RSpotify::authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_KEY'])
