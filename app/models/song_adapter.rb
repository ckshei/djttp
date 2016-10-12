class SongAdapter

  def self.create(track)
    song = Song.create(name: track.name, spotify_song_id: track.id, artist: track.artists.first.name)
    song
  end

end
