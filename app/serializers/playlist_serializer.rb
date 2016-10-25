class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :spotify_url, :sync_url, :song_count

  def sync_url
    Rails.application.routes.url_helpers.sync_event_url(object.event_id, host: "http://playlister.co")
  end

  def song_count
    object.song_ids.count
  end
end
