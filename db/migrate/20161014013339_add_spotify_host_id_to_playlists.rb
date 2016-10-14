class AddSpotifyHostIdToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :spotify_host_id, :string
  end
end
