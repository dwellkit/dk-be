class WarrantiesController < ApplicationController

  def create
    @warranty = Warranty.new(warranty_params)
    @warranty.save!
    if @warranty.save
      render json: { :warranty => @warranty }, status: :created
    else
      render json: { :error => "Unable to create contact" }, status: :not_modified
    end
  end

  def contact
    @warranty = Warranty.find(params[:id])
    contact = Contact.find(params[:id])
    contact.update_attribute(:reachable, @warranty)
    @contacts = @warranty.contacts.all
  end


  private

  def add_params

  end

  def warranty_params
    params.require(:warranty).permit(:name, :warranty_number, :description, :expiration_date, :url, :notes)
  end

end

