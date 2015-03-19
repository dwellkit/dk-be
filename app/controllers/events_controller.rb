class EventsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_events, only: [:show]

  def create
    # via: https://github.com/mperham/sidekiq/wiki/Scheduled-Jobs
    @event = current_user.events.create(event_params)
    EventNotifyJob.set(wait_until: @event.event_date - 5.days).perform_later(@event, 'soon')
    EventNotifyJob.set(wait_until: @event.event_date - 1.day).perform_later(@event, 'imminent')
    EventNotifyJob.set(wait_until: @event.event_date).perform_later(@event, 'day_of')
    render json: { :event => @event }
  end

  def email
    EventMailer.event_email(current_user).deliver_now
    render json: { :message => "Email has been sent" }, status: :ok
  end

  def show
    if @events
      render json: { :events => @events }, status: :ok
    else
      render json: { :error => "Currently no events scheduled"}, status: :not_found
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :notes, :event_date, :event_frequency)
    end

    def set_events
      @events = current_user.events
    end

end
