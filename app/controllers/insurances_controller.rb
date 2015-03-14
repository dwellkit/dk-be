class InsurancesController < ApplicationController

  def index
    @insurances = Insurance.all
      if @insurances
        render "insurance/index.json.jbuilder", status: :ok
      else
        render json: { :error => "Unable to find policies" }, status: :unprocessable_entity
    end
  end

  def show
    @insurance = Insurance.find(params[:pid])
      if @insurance
        render "insurance/index.json.jbuilder", status: :ok
      else
        render json: { :error => "Unable to find policies" }, status: :unprocessable_entity
    end
  end

  def create
    @item = set_item
    @insurance = @item.insurances.new(insurance_params)
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
    @item = set_item
    @insurance = @item.insurances.find(params[:pid])
    @contact = set_contact
    if @contact
      add_contact = @contact.update_attribute(:reachable, @insurance)
      render json: { :insurace => @insurace, :contact => @contact }, status: :ok
    else
      render json: { :error => "Unable to add contact" }, status: :not_modified
    end
  end

  def update
    @insurance = Insurance.find(params[:pid])
      if @insurace.update(insurance_params)
        render "insurance/index.json.jbuilder", status: :accepted
      else
        render json: {:error => "Unable to edit the policy"}, status: :not_modified
      end
  end

  def destroy
    @insurance = Insurance.find(params[:pid])
      if @insurance.destroy!
        render json: { :message => "#{@insurance.id} - #{@insurance.name} Removed"}, status: :ok
      else
        render json: {:error => "Unable to delete the policy"}, status: :not_modified
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
    @contact = Contact.find(params[:cid])
  end

  def set_item
    @item = Item.find(params[:iid])
  end
end

