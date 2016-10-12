class SongAdapter

  def self.find_or_create_by(spotify_track)
    song = Song.find_or_create_by(name: spotify_track.name, spotify_song_id: spotify_track.id, artist: spotify_track.artists.first.name)
    song
  end

end
