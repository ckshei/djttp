class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :event_id
      t.integer :host_id
      t.string :spotify_playlist_id
      t.string :spotify_url
      t.string :rsvp_url

      t.timestamps null: false
    end
  end
end
