class Event < ActiveRecord::Base
  belongs_to :host, :class_name => "User"
  has_one :playlist
  has_many :event_guests
  has_many :guests, through: :event_guests, :class_name => "User"
  has_many :songs, through: :guests
  scope :expired, -> { where('date < ?', Date.today) }

  def create_playlist
    hash = self.host.spotify_hash
    user = RSpotify::User.new(hash)
    spotify_playlist = user.create_playlist!("#{self.name}-playlist") 
    spotify_playlist.add_tracks!(user.top_tracks(limit: 5)) 
    playlist = Playlist.new
    user.top_tracks(limit:5).each do |track_id| 
      song = SongAdapter.find_or_create_by(track_id)
      playlist.songs << song
    end
    playlist.update(
      event_id: self.id,
      host_id: user.id, 
      spotify_playlist_id: spotify_playlist.id,
      spotify_url: spotify_playlist.external_urls["spotify"]
    )
    playlist.save
  end

  def add_songs(user_obj)
    user = RSpotify::User.new(user_obj.spotify_hash)
    spotify_playlist = RSpotify::Playlist.find(playlist.host_id.to_s, playlist.spotify_playlist_id)
    user.top_tracks(limit: 5).each do |spotify_track|
      song = SongAdapter.find_or_create_by(spotify_track)
      if playlist.songs.include? song
        byebug
        playlist_song.find_by(song_id: song.id, playlist_id: playlist.id)
      else
        playlist.songs << song
      end
    end
    byebug
    spotify_playlist.add_tracks!(user.top_tracks(limit: 5)) 
  end

  def refresh_playlist
    spotify_playlist = RSpotify::Playlist.find(playlist.host_id.to_s, playlist.playlist_id)
    playlist.add_songs.each do |id|
      add_tracks << RSpotify::Track.find(id)
    end
    playlist.add_songs.clear
    playlist.save
    spotify_playlist.add_tracks!(add_tracks)
  end
end
