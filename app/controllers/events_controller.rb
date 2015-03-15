class EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    @event = Event.create(event_params)
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
    params.require(:event).permit(:name, :notes)
  end


end
