class PicturesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_item, :only => [:add_item_image]
  before_action :set_room, :only => [:add_room_image]
  before_action :set_property, :only => [:add_property_image]
  before_action :set_picture, :only => [:destroy]

  def destroy
    if @picture.destroy!
      render json: { :message => 'The selected picture has been deleted.'}, status: :ok
    else
      render json: {:error => 'Could not delete the selected picture'}, status: :not_modified
    end
  end

  def add_item_image
    @picture = @item.pictures.new( image_params )
    @picture.update(:item_id => @item.id)
    if @picture.update_attribute(:picturable, @item)
      render json: { :image => @picture.image.url(:thumb) }, status: :created
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
    end
  end

  def add_room_image
    @picture = @room.pictures.new( image_params )
    @picture.update(:room_id => @room.id)
    if @picture.update_attribute(:picturable, @room)
      render json: { :image => @picture.image.url(:thumb) }, status: :created
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
    end
  end

  def add_property_image
    @picture = @property.pictures.create( image_params )
    @picture.update(:property_id => @property.id)
    if @picture.update_attribute(:picturable, @property)
      render json: { :image => @picture.image.url(:thumb) }
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
    end
  end


  private

    def image_params
      params.require(:file).permit(:image)
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    def set_room
      @room = Room.find(params[:room_id])
    end

    def set_property
      @property = Property.find(params[:property_id])
    end

end
