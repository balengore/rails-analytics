class Event < ActiveRecord::Base
  #Add callback to cache events when saved/updated
  after_save :cache_event

  def cache_event
    Rails.cache.write("event_#{self.id}",self)
  end

  #On finds, check the cache first, and insert if not present
  def self.find_cached(id)
    Rails.cache.fetch("event_#{id}") { Event.find(id) }
  end

  #Check the cache for Event.all, and insert it if not present
  def self.all_cached
    Rails.cache.fetch('event_all') { all }
  end
end
