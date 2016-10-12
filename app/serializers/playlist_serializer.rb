class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :spotify_url, :rsvp_url
end
