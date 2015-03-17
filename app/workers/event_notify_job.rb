class EventNotifyJob
  include Sidekiq::Worker

  def perform(event, urgency)
    # case (urgency)
    # when :day_of
    #   new_event = event.event_date + event.event_frequency.seconds
    #   EventNotifyJob.perform_at(@event.event_date - 5.days, @event, :soon)
    #   EventNotifyJob.perform_at(@event.event_date - 1.day, @event, :imminent)
    #   EventNotifyJob.perform_at(@event.event_date, @event, :day_of)
    #   event.update(event_date: new_event)
    # when :soon
    #   binding.pry
    # when :imminent
    #   binding.pry
    # end
    puts "hellloooo"
  end
end