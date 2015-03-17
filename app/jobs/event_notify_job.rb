class EventNotifyJob < ActiveRecord::Base
  queue :default

  def perform(event, urgency)
    case (urgency)
      when :day_of
        new_event = event.event_date + event.event_frequency.seconds
        EventNotifyJob.new(event, :soon).set(wait_until: new_event - 5.days).perform_later
        EventNotifyJob.new(event, :imminent).set(wait_until: new_event - 1.day).perform_later
        EventNotifyJob.new(event, :day_of).set(wait_until: new_event).perform_later
        event.update(event_date: new_event)
      when :soon


      when :imminent



  end

end
