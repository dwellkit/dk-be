require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue ScheduledJob.new }


every(2.minutes, 'reminder.deliver') {
  reminders = Reminder.find(:all, :conditions => ["reminder_at <= ? and reminder_at > ?", Time.now.advance(:minutes => 2), Time.now])
  events = Event.all
  events.each do |event|
      time_range = (event.event_date - 5.day)..Time.now.midnight
end

  unless reminders.nil?
  UserMailer.send_later( :deliver_event_reminder, reminders )
end
}

