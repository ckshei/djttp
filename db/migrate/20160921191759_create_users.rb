class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid, :limit => 8
      t.string :display_name
      t.string :password_digest
      t.string :email
      t.string :top_tracks
      t.string :top_artists

      t.timestamps null: false
    end
  end
end
