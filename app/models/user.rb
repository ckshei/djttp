class User < ActiveRecord::Base
  serialize :spotify_hash, Hash
  serialize :top_tracks, Array
  serialize :top_artists, Array

  #for host
  has_many :events, :foreign_key => 'host_id'
  has_many :guests, through: :events 
  #for guest
  has_many :event_guests, :foreign_key => "guest_id"
  has_many :reservations, through: :event_guests, :source =>"event"

  def has_uid
    self.uid?
  end

end
