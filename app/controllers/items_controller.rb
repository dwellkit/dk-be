class ItemsController < ApplicationController

  before_action :authenticate_user_from_token!
  before_action :set_property_items, only: [:property_items, :index]
  before_action :set_room_items, only: [:room_items]
  before_action :set_room, only: [:add_room_item, :create]
  before_action :set_property, only: [:add_room_item, :create_property_item, :add_image, :create]
  before_action :set_item, only: [:destroy, :add_image, :all_images, :update]



  def property_items
    render json: { :items => @items}, status: :ok
  end

  def room_items
    render json: { :items => @items }, status: :ok
  end

  def update
    if @item.update( item_params )
      render json: { :item => @item }, status: :ok
    else
      render json: { :error => "Unable to update item"}, status: :not_found
    end
  end

  def index
    render json: { :items => @items }, status: :ok
  end

  def create
    @item = @room.items.new
    @item.update(:property_id => @property.id)
    @item.update( item_params )
    render json: { :item => @item }, status: :created
  end

  def create_property_item
    @item = @property.items.create( item_params )
    render json: { :item => @item}, status: :created
  end

  def destroy
    if @item.destroy
      render json: { :message => "Item #{@item.id} #{@item.name} was deleted."}, status: :ok
    else
      render json: { :error => "There was an error deleting the item"}, status: :not_modified
    end
  end

  def add_image
    @picture = @item.pictures.new( image_params )
    @picture.update(:item_id => @item.id)
    if @picture.update_attribute(:picturable, @item)
      render json: { :image => @picture.image.url(:thumb) }, status: :created
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
    end
  end

  def all_images
    if @pictures = @item.pictures.all
      render "item/images.json.jbuilder", status: :ok
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
      params.require(:item).permit(:image)
    end

    def set_property_items
      @property = Property.find(params[:id])
      @items = @property.items.all
    end

    def set_room_items
      @room = set_room
      @items = @room.items.all
    end

    def set_room
      @room = Room.find(params[:room_id])
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def set_property
      @property = Property.find(params[:property_id])
    end

    def item_params
      params.require(:item).permit(:category, :name, :purchase_date, :serial_number, :price, :condition)
    end

end
