class EventNotifyJob < ActiveJob::Base
  queue :default

  def perform(event, urgency)
    case (urgency)
    when :day_of
      EventMailer.reminder_day_of_email(event).deliver_now
      new_event = event.event_date + event.event_frequency.seconds
      EventNotifyJob.perform_at(@event.event_date - 5.days, @event, :soon)
      EventNotifyJob.perform_at(@event.event_date - 1.day, @event, :imminent)
      EventNotifyJob.perform_at(@event.event_date, @event, :day_of)
      event.update(event_date: new_event)
    when :soon
      EventMailer.reminder_soon_email(event).deliver_now
    when :imminent
      EventMailer.reminder_imminent_email(event).deliver_now
    end
  end
end
