class WarrantiesController < ApplicationController

  def index
    @warranties = Warranty.all
      if @warranties
        render "warranty/index.json.jbuilder", status: :ok
      else
        render json: { :error => "Unable to find warranties" }, status: :unprocessable_entity
    end
  end

  def show
    @item = set_item
    @warranty = Warranty.find(params[:wid])
      if @warranty
        render "warranty/index.json.jbuilder", status: :ok
      else
        render json: { :error => "Unable to find warranties" }, status: :unprocessable_entity
    end
  end

  def create
    @item = set_item
    @warranty = @item.warranties.new(warranty_params)
    if @warranty.save!
      if contact_params
        @contact = @warranty.contacts.new(contact_params)
        add_contact = @contact.update_attribute(:reachable, @warranty)

        render "warranty/index.json.jbuilder", status: :created
      elsif
        render json: {:error => "Unable to add contact" }, status: :not_modified
    else
      render json: { :error => "Unable to create Warranty" }, status: :not_modified
    end
    end
  end

  def add_contact
    @item = set_item
    @warranty = @item.warranties.find(params[:wid])
    @contact = set_contact
    if @contact
      add_contact = @contact.update_attribute(:reachable, @warranty)
      render "warranty/index.json.jbuilder", status: :accepted
    else
      render json: {:error => "Unable to add contact" }, status: :not_modified
    end
  end

  def update
    @warranty = Warranty.find(params[:wid])
      if @warranty.update(warranty_params)
        render "warranty/index.json.jbuilder", status: :accepted
      else
        render json: {:error => "Unable to edit the warranty"}, status: :not_modified
      end
  end

  def delete
    @warranty = Warranty.find(params[:wid])
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
    params.require(:contact).permit(:name, :telephone_number, :email, :url, :notes, :fax_number)
  end

  def set_contact
    @contact = Contact.find(params[:cid])
  end

  def set_item
    @item = Item.find(params[:iid])
  end
end
