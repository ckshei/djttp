class UserAdapter

  def self.create(spotify_user)
    hash = spotify_user.to_hash
    user = User.find_or_create_by(:uid => hash["id"])
    user.update(
      :display_name => hash["display_name"],
      :email => hash["email"],
      :spotify_hash => spotify_user.to_hash
    )
    user
  end

  def self.top_tracks(user)
    user.songs.each do |song|
    song_id = RSpotify::Track.search(song.name).first.id
    user.top_tracks << song_id
    end
    user.save
  end

end
