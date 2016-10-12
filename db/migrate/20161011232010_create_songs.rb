class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :spotify_id
      t.string :artist

      t.timestamps null: false
    end
  end
end
