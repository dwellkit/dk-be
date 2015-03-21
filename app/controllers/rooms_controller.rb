class RoomsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_room, only: [:update, :destroy, :add_image, :all_images]
  before_action :set_property, only: [:create, :add_image, :all_images]


  def create
    @room = @property.rooms.new
    if @room.update( room_params )
      render json: { :room => @room }, status: :created
    else
      render json: { :error => "Could not update room" }, status: :not_modified
    end
  end

  def index
    if @rooms
      render json: { :rooms => @rooms }, status: :ok
    else
      render json: { :error => "Could not find room" }, status: :not_found
    end
  end

  def update
    binding.pry
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
    @picture = @room.pictures.new( image_params )
    @picture.update(:room_id => @room.id)
    if @picture.update_attribute(:picturable, @room)
      render json: { :image => @picture.image.url(:thumb) }, status: :created
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
    end
  end

  def all_images
    @pictures = Picture.where(:room_id => @room.id)
    if @pictures
      render "room/images.json.jbuilder", status: :ok
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
      @room = Room.find(params[:id])
    end

    def set_rooms
      @rooms = Property.find(params[:property_id]).rooms
    end

    def set_property
      @property = Property.find(params[:property_id])
      binding.pry
    end
end
