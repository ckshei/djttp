class EventPlaylistSerializer < ActiveModel::Serializer
  attributes :id
  has_many :playlist_songs
end
