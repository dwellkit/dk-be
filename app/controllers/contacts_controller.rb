class ContactsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    @contacts = Contact.all
    render json: { :contact => @contacts}
  end

  def show
    @contact = set_contact
    if @contact
      render json: { :contact => @contact }
    else
      render json: { :error => "Unable to find contact" }, status: :unprocessable_entity
    end
  end

  def create
    binding.pry
    @property = set_property
    binding.pry
    @contact = @property.contacts.new(contact_params)
    if @contact.save
      render json: { :property => @property, :contact => @contact }, status: :created
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

  def delete
    @contact = set_contact
    if @contact.destroy
      render json: { :contact => @contact }, status: :ok
    else
      render json: { :error => "Unable to delete the contact" }, status: :unprocessable_entity
    end
  end

  private

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




