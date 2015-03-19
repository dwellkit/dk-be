class RoomsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_room, only: [:edit, :destroy]
  before_action :set_property, only: [:add]


  def add
    @room = @property.rooms.new
    if @room.update( room_params )
      render json: { :room => @room }, status: :created
    else
      render json: { :error => "Could not update room" }, status: :not_modified
    end
  end

  def edit
    if @room.update( room_params )
      render json: { :room => @room }, status: :created
    else
      render json: { :error => "Could not update room" }, status: :not_modified
    end
  end

  def destroy
    if @room.destroy
      render json: { :message => "#{@room.id} - #{@room.name} Removed" }, status: :ok
    else
      render json: { :error => "Unable to remove room." }, status: :not_modified
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :sqft, :dimensions, :flooring_type, :wall_type,
                                 :paint_color)
  end

  def set_room
    @room = Room.find(params[:rid])
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
