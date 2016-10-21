  puts ENV['SPOTIFY_ID']
  puts ENV['SPOTIFY_KEY']
  puts "hello"
  RSpotify::authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_KEY'])
