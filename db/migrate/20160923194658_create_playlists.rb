class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :event_id
      t.integer :host_id
      t.string :playlist_id
      t.text :current_songs
      t.text :add_songs
      t.string :url

      t.timestamps null: false
    end
  end
end
