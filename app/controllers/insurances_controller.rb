class InsurancesController < ApplicationController

  def create
    @insurance = Insurance.new(insurance_params)
      if @insurance.save!
        if contact_params
          @contact = @insurance.contacts.new(contact_params)
          add_contact = @contact.update_attribute(:reachable, @insurance)

          render "insurance/index.json.jbuilder", status: :created
        elsif
          render json: {:error => "Unable to add contact" }, status: :not_modified
      else
        render json: { :error => "Unable to create Warranty" }, status: :not_modified
      end
    end
  end

  def add_contact
    @insurance = Insurance.find(params[:id])
    @contact = set_contact
    if @contact
      add_contact = @contact.update_attribute(:reachable, @insurace)
      render json: { :insurace => @insurace, :contact => @contact }, status: :ok
    else
      render json: { :error => "Unable to add contact" }, status: :not_modified
    end
  end

  private

  def insurance_params
    params.require(:insurance).permit(:company, :description, :policy_number, :expiration_date, :url, :notes)
  end

  def contact_params
    params.require(:contact).permit(:name, :telephone_number, :email, :url, :notes, :fax_number)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

end


