class AddAddSongsToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :add_songs, :text_field
  end
end
