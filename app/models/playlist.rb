class Playlist < ActiveRecord::Base
  belongs_to :event
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
  serialize :current_songs, Set
  serialize :add_songs, Array
  validates :spotify_url, presence: :true
end
