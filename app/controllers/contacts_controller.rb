class ContactsController < ApplicationController
  before_action :authenticate_user_from_token!

  def property_contacts
    @contacts = set_property_contacts
    if @contacts
      render json: { :contact => @contacts}
    else
      render json: {:error => "Unable to find contact" }, status: :unprocessable_entity
    end
  end

  def show
    @property = set_property
    @contact = Contact.find(params[:cid])
    if @contact
      render json: { :contact => @contact }
    else
      render json: { :error => "Unable to find contact" }, status: :unprocessable_entity
    end
  end

  def create
    @property = set_property
    @contact = @property.contacts.new
    if @contact.update(:property_id => @property.id)
      render "contact/index.json.jbuilder", status: :created
    else
      render json: { :error => "Unable to create contact"}, status: :not_modified
    end
  end

  def update
    @contact = set_contact
    @contact.update(contact_params)
    if @contact.save!
      render json: { :contact => @contact }, status: :ok
    else
      render json: { :error => "Unable to update the contact" }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = set_contact
    if @contact.destroy
      render json: { :contact => @contact }, status: :ok
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
    params.require(:contact).permit(:name, :telephone_number, :email, :url, :notes, :fax_number)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
end




