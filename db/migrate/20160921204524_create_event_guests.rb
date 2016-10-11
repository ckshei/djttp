class CreateEventGuests < ActiveRecord::Migration
  def change
    create_table :event_guests do |t|
      t.integer :event_id
      t.integer :guest_id

      t.timestamps null: false
    end
  end
end
