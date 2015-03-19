class RoomsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_room, only: [:edit, :destroy, :add_image, :all_images]
  before_action :set_property, only: [:add, :add_image, :all_images]


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

  def add_image
    @picture = Picture.create( image_params )
    if @picture.update_attribute(:picturable, @room)
      render json: { :image => @room.picture.url(:thumb) }
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
  end

  def all_images
    if @pictures = @room.pictures.all
      render json: { :images => @pictures }
    else
      render json: { :error => "Couldn't find the Room's pictures"}
    end
  end

  def show_image
    @picture = Picture.find(params[:xid])
    if @picture
      render json: { :image => @picture }, status: :ok
    else
      render json: { :error => "Couldn't find the picture"}
    end
  end

  private

  def image_params
    params.require(:room).permit(:image)
  end

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
