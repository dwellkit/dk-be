class ItemsController < ApplicationController

  before_action :authenticate_user_from_token!
  before_action :set_property_items, only: [:property_items]
  before_action :set_room_items, only: [:room_items]
  before_action :set_room, only: [:add_room_item, :add_image, :all_images]
  before_action :set_property, only: [:add_room_item, :add_property_item, :add_image, :all_images]
  before_action :set_item, only: [:destroy, :edit, :add_image, :all_images]



  def property_items
    render json: { :items => @items}, status: :ok
  end

  def room_items
    render json: { :items => @items }, status: :ok
  end

  def add_room_item
    @item = @room.items.new
    @item.update(:property_id => @property.id)
    @item.update( item_params ) #if then render
    render json: { :item => @item }, status: :created
  end

  def add_property_item
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

  def edit
    @item.update( item params ) #if then render
  end

   def add_image
    binding.pry
    @picture = Picture.create( image_params )
    if @picture.update_attribute(:picturable, @item)
      render json: { :image => @item.picture.url(:thumb) }, status: :created
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
    end
  end

  def all_images
    if @pictures = @image.pictures.all
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
      @room = Room.find(params[:rid])
    end

    def set_item
      @item = Item.find(params[:iid])
    end

    def set_property
      @property = Property.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:category, :name, :purchase_date, :serial_number, :price, :condition)
    end

end
