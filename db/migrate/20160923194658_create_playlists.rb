class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :event_id
      t.string :spotify_host_id
      t.string :spotify_playlist_id
      t.string :spotify_url
      t.text :add_songs

      t.timestamps null: false
    end
  end
end
