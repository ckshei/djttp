class Playlist < ActiveRecord::Base
  belongs_to :event
  serialize :current_songs, Set
  serialize :add_songs, Set
end
