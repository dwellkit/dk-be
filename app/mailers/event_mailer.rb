class EventMailer < ActionMailer::Base
  default from: 'dwellingk@gmail.com'

  def event_email(user)
    @user = user
    mail(to: @user.email)
  end

  def reminder_soon_email(event)
    @event = event
    mail(to: event.user.email)
  end

  def reminder_imminent_email(event)
    @event = event
    mail(to: event.user.email)
  end

  def reminder_day_of_email(event)
    @event = event
    mail(to: event.user.email)
  end

end
