class WarrantiesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_warranties, only: [:index]
  before_action :set_item, only: [:show, :create, :add_contact]
  before_action :set_warranty, only: [:show, :update, :add_contact, :delete]
  before_action :set_contact, only: [:add_warranty]
  before_action :set_property, only: [:create]

  def index
    if @warranties
      render json: { :warranties => @warranties }, status: :ok
    else
      render json: { :error => "Unable to find warranties" }, status: :unprocessable_entity
    end
  end

  def show
    if @warranty
      render "warranty/index.json.jbuilder", status: :ok
    else
      render json: { :error => "Unable to find warranties" }, status: :unprocessable_entity
    end
  end

  def create
    @warranty = @property.warranties.create
    if params[:item_id]
      @warranty.update(:item_id => params[:iid])
    end
    if @warranty.update(warranty_params)
      if contact_params
        @contact = @warranty.contacts.new(contact_params)
        @contact.update_attribute(:reachable, @warranty)
        @contact.update(:warranty_id => @warranty.id)
      end
      render json: { warranty: @warranty }, status: :created
    else
      render json: { :error => "Unable to create Warranty" }, status: :not_modified
    end
  end

  def add_warranty
    if @contact
      @contact.update_attribute(:reachable, @warranty)
      render "warranty/index.json.jbuilder", status: :accepted
    else
      render json: {:error => "Unable to add contact" }, status: :not_modified
    end
  end

  def update
    if @warranty.update(warranty_params)
      render "warranty/index.json.jbuilder", status: :accepted
    else
      render json: {:error => "Unable to edit the warranty"}, status: :not_modified
    end
  end

  def delete
    if @warranty.destroy!
      render json: { :message => "#{@warranty.id} - #{@warranty.name} Removed"}, status: :ok
    else
      render json: {:error => "Unable to delete the warranty"}, status: :not_modified
    end
  end


  private
    def warranty_params
      params.require(:warranty).permit(:name, :warranty_number, :description, :expiration_date, :url, :notes)
    end

    def contact_params
      if params[:contact]
        params.require(:contact).permit(:name, :telephone_number, :email, :url, :notes, :fax_number)
      end
    end

    def set_contact
      @contact = Contact.find(params[:contact_id])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    def set_warranties
      @property = Property.find(params[:property_id])
      @warranties = @property.warranties
      # @warranties = Item.find(params[:iid]).warranties
    end

    def set_property
      @property = Property.find(params[:property_id])
    end

    def set_warranty
      @warranty = Warranty.find(params[:id])
    end
end
