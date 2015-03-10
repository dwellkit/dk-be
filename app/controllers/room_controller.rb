class RoomController < ApplicationController
  before_action :authenticate_user_from_token!

  def add
    @room = @property.rooms.new
    if @room.update( room_params )
      render json: { :room => @room }, status: :created
    else
      render json: { :error => "Could not update room" }, status: :not_modified
    end
  end

  def edit
    @room = set_room
    if @room.update( room_params )
      render json: { :room => @room }, status: :created
    else
      render json: { :error => "Could not update room" }, status: :not_modified
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :sqft, :dimesions, :flooring_type, :wall_type,
                                 :paint_color)
  end

  def set_room
    @room = Room.find(params[:rid])
  end

  def set_property
    @property = Property.find(params[:id])
  end
end