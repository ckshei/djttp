class PlaylistSongSerializer < ActiveModel::Serializer
  attributes :song_name, :request_count

  def song_name
    object.song.name
  end
end
