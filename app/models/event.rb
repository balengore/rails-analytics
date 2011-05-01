class Event < ActiveRecord::Base
  after_save :cache_event

  def cache_event
    Rails.cache.write("event_#{self.id}",self)
  end
end
