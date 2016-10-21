class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :guest_count, :event_url
  has_one :playlist

  def guest_count
    object.guest_ids.count
  end

  def event_url
    Rails.application.routes.url_helpers.event_url(object.id, host: "www.playlister.co")
  end
end
