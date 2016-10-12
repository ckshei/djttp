class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :display_name
      t.string :email
      t.text :spotify_hash
      t.date :birthdate
      t.string :image
      t.string :username

      t.timestamps null: false
    end
  end
end
