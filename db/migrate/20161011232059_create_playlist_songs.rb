class CreatePlaylistSongs < ActiveRecord::Migration
  def change
    create_table :playlist_songs do |t|
      t.integer :playlist_id
      t.integer :song_id
      t.integer :request_count

      t.timestamps null: false
    end
  end
end
