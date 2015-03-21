class InsurancesController < ApplicationController

  before_action :authenticate_user_from_token!
  before_action :set_insurances, only: [:index]
  before_action :set_insurance, only: [:show, :delete, :update]
  before_action :set_item, only: [:create, :add_contact]
  before_action :set_contact, only: [:add_contact]

  def index
      if @insurances
        render "insurance/index.json.jbuilder", status: :ok
      else
        render json: { :error => "Unable to find policies" }, status: :unprocessable_entity
    end
  end

  def show
    if @insurance
      render "insurance/index.json.jbuilder", status: :ok
    else
      render json: { :error => "Unable to find policies" }, status: :unprocessable_entity
    end
  end

  def create
    binding.pry
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
    @insurance = @item.insurances.find(params[:pid])
    if @contact
      add_contact = @contact.update_attribute(:reachable, @insurance)
      render json: { :insurace => @insurace, :contact => @contact }, status: :ok
    else
      render json: { :error => "Unable to add contact" }, status: :not_modified
    end
  end

  def update
      if @insurace.update(insurance_params)
        render "insurance/index.json.jbuilder", status: :accepted
      else
        render json: {:error => "Unable to edit the policy"}, status: :not_modified
      end
  end

  def delete
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

    def set_insurances
      @insurances = Insurance.all
    end

    def set_insurance
      @insurance = Insurance.find(params[:pid])
    end
end

