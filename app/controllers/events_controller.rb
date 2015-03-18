class EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    # via: https://github.com/mperham/sidekiq/wiki/Scheduled-Jobs
    @event = current_user.events.create(event_params)
    EventNotifyJob.set(wait_until: @event.event_date - 5.days).perform_later(@event, 'soon')
    EventNotifyJob.set(wait_until: @event.event_date - 1.day).perform_later(@event, 'imminent')
    EventNotifyJob.set(wait_until: @event.event_date).perform_later(@event, 'day_of')
    render json: { :event => @event }
  end

  def email
    # @event = Event.find(params[:eid])
    @user = current_user
    binding.pry
    EventMailer.event_email(current_user).deliver_now
    render json: { :message => "Email has been sent" }, status: :ok
  end

  private

    def event_params
      params.require(:event).permit(:name, :notes, :event_date, :event_frequency)
    end

end
