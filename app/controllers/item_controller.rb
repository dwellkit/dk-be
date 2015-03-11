class ItemController < ApplicationController
  before_action :authenticate_user_from_token!

  # THIS CONTROLLER IS SUPER MESSY AND TERRIBLE, KILL IT BY REFACTOR
  #                                                           - dylan

  def property_items
    @items = set_property_items
  end

  def room_items
    @items = set_room_items
  end

  def add_room_item
    @room = set_room
    @property = set_property
    @item = @room.items.new
    @item.update(:property_id => @property.id)
    @item.update( item_params ) #if then render
    render json: { :item => @item }, status: :created
  end

  def add_property_item
    @property = set_property
    @item = @property.items.create( item_params )
    render json: { :item => @item}, status: :created
  end

  def destroy
    @item = set_item
    if @item.destroy
      render json: { :message => "Item #{@item.id} #{@item.name} was deleted."}, status: :ok
    else
      render json: { :error => "There was an error deleting the item"}, status: :not_modified
    end

  end

  def edit
    @item = set_item
    @item.update( item params ) #if then render
  end


  private

    def set_property_items
      @items = Property.find(params[:id]).rooms.items.all
    end

    def set_room_items
      @items = Room.find(params[:rid]).items.all
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
