class EventsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_events, only: [:index]
  before_action :set_event, only: [:destroy]

  def create
    @event = current_user.events.create(event_params)
    # EventNotifyJob.set(wait_until: @event.event_date - 5.days).perform_later(@event, 'soon')
    # EventNotifyJob.set(wait_until: @event.event_date - 1.day).perform_later(@event, 'imminent')
    # EventNotifyJob.set(wait_until: @event.event_date).perform_later(@event, 'day_of')
    render json: { :event => @event }
  end

  def index
    if @events
      render json: { :events => @events }, status: :ok
    else
      render json: { :error => "Currently no events scheduled"}, status: :not_found
    end
  end

  def destroy
    if @event.destroy
      render json: { :message => "Event #{@event.name} deleted" }, status: :ok
    else
      render json: { :error => "Could not find event"}, status: :not_found
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :notes, :event_date, :event_frequency)
    end

    def set_events
      @events = current_user.events
    end

    def set_event
      @event = Event.find(params[:id])
    end

end
