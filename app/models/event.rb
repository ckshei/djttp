class Event < ActiveRecord::Base
  belongs_to :host, :class_name => "User"
  has_one :playlist
  has_many :event_guests
  has_many :guests, through: :event_guests, :class_name => "User"
  has_many :songs, through: :guests
  scope :expired, -> { where('date < ?', Date.today) }

  validates :name, presence: true
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    return unless date
    if date < Date.today
      errors.add(:date, "Cannot be in the past")
    end
  end

  def create_playlist
    hash = self.host.spotify_hash
    user = RSpotify::User.new(hash)
    spotify_playlist = user.create_playlist!("#{self.name}-playlist") 
    s_top_tracks = user.top_tracks(limit: 7, time_range: 'short_term')
    add_songs = []
    if s_top_tracks.any?
      spotify_playlist.add_tracks!(s_top_tracks) 
      s_top_tracks.each do |spotify_track| 
        song = SongAdapter.find_or_create_by(spotify_track)
        add_songs << song
      end
    end
    self.playlist = Playlist.new(
      event_id: self.id,
      spotify_host_id: self.host.uid,
      spotify_playlist_id: spotify_playlist.id,
      spotify_url: spotify_playlist.external_urls["spotify"],
      songs: add_songs
    )
  end

  def add_songs(user_obj)
    user = RSpotify::User.new(user_obj.spotify_hash)
    s_top_tracks = user.top_tracks(limit: 7, time_range: 'short_term')
    add_songs = []
    if s_top_tracks.any?
      s_top_tracks.each do |spotify_track|
        song = SongAdapter.find_or_create_by(spotify_track)
        if playlist.songs.include? song
          playlist_song = PlaylistSong.find_by(song_id: song.id, playlist_id: playlist.id)
          playlist_song.update(request_count: playlist_song.request_count + 1)
        else
          add_songs << spotify_track
          playlist.songs << song
        end
      end
    if add_songs.any? 
      spotify_playlist = RSpotify::Playlist.find(playlist.spotify_host_id, playlist.spotify_playlist_id)
      spotify_playlist.add_tracks!(add_songs)
    end
    end
  end

  def refresh_playlist
    spotify_playlist = RSpotify::Playlist.find(playlist.spotify_host_id, playlist.spotify_playlist_id)
    songs_array = spotify_playlist.tracks
    songs_array.each do |spotify_track|
      song = SongAdapter.find_or_create_by(spotify_track)
      unless playlist.songs.include? song
        playlist.songs << song
      end
    end
    playlist.save
  end
end
