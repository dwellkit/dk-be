class WarrantiesController < ApplicationController

  def create
    @warranty = Warranty.new(warranty_params)
    if @warranty.save!
      if contact_params
        new_contact = @warranty.contacts.new(contact_params)
        add_contact = new_contact.update_attribute(:reachable, @warranty)
        render json: { :warranty => @warranty }, status: :created
      elsif
        render json: {:error => "Unable to add contact" }, status: :not_modified
    else
      render json: { :error => "Unable to create Warranty" }, status: :not_modified
    end
    end
  end

  def add_contact
    @warranty = Warranty.find(params[:id])
    existing_contact = set_contact
    if existing_contact
      add_contact = existing_contact.update_attribute(:reachable, @warranty)
      render json: {:warranty => @warranty, :cotact => @contact}
    else
      render json: {:error => "Unable to add contact" }, status: :not_modified
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
    @contact = Contact.find(params[:id])
  end

end

