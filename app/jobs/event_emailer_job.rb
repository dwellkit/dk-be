class EventEmailerJob 
  include SuckerPunch::Job
  
  def perform(event, urgency)
    case (urgency)
    when 'day_of'
      EventMailer.reminder_day_of_email(event).deliver_now
      if event.event_frequency
        new_event = event.event_date + event.event_frequency.seconds
        EventEmailerJob.set(wait_until: event.event_date - 5.days).perform_later(event, :soon)
        EventEmailerJob.set(wait_until: event.event_date - 1.day).perform_later(event, :imminent)
        EventEmailerJob.set(wait_until: event.event_date_).perform_later(event, :day_of)
        event.update(event_date: new_event)
      end
    when 'soon'
      EventMailer.reminder_soon_email(event).deliver_now
    when 'imminent'
      EventMailer.reminder_imminent_email(event).deliver_now
    end
  end
end
