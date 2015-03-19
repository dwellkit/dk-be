class ContactsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :set_property, only: [:create]
  before_action :set_property_contacts, only: [:property_contacts]

  def property_contacts
    if @contacts
      render json: { :contacts => @contacts}
    else
      render json: {:error => "Unable to find contact" }, status: :unprocessable_entity
    end
  end

  def show
    if @contact
      render json: { :contact => @contact }
    else
      render json: { :error => "Unable to find contact" }, status: :unprocessable_entity
    end
  end

  def create
    @contact = @property.contacts.new
    @contact.update (contact_params )
    if @contact.update(:property_id => @property.id)
      render "contact/index.json.jbuilder", status: :created
    else
      render json: { :error => "Unable to create contact"}, status: :not_modified
    end
  end

  def update
    @contact.update(contact_params)
    if @contact.save!
      render json: { :contact => @contact }, status: :ok
    else
      render json: { :error => "Unable to update the contact" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @contact.destroy
      render json: { :message => "contact #{@contact.name} successfully removed" }, status: :ok
    else
      render json: { :error => "Unable to delete the contact" }, status: :unprocessable_entity
    end
  end

  private

  def set_property_contacts
      @property = Property.find(params[:id])
      @contacts = @property.contacts.all
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :company, :telephone_number, :email, :url, :notes, :fax_number)
  end

  def set_contact
    @contact = Contact.find(params[:cid])
  end
end





