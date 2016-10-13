class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :spotify_url, :rsvp_url, :song_count

  def rsvp_url
    Rails.application.routes.url_helpers.rsvp_event_url(object.event_id, host: "localhost:3000")
  end

  def song_count
    object.song_ids.count
  end
end
