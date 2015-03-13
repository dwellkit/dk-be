class PropertiesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_property, only: [:edit, :reimport, :destroy]

  def index
  end

  # user has many properties through groundskeepers
  # properties has one address
  # user has many addresses through properties

  def add
    @property = Property.create
    @property.users = [current_user]
    if !address_exists?
      if @property.create_from_zillow!( property_params ) == false
        render json: { :error => "unable to find property" }, status: :not_modified
      elsif @property.save
        @rooms = @property.rooms.all
        render "property/index.json.jbuilder", status: :ok
      else
        render json: { :error => "Unable to find property"}, status: :not_modified
      end
    else
      render json: { :error => "Property already in account."}, status: :not_acceptable
    end
  end

  def edit
    @property = set_property
    if @property.update( property_params )
      render json: { :property => @property}, status: :created
    else
      render json: { :error => "Unable to edit property"}, status: :not_modified
    end
  end

  def reimport
    @property = set_property
    if @property.add(property_params) == false
      render json: { :error => "unable to find property"}, status: :not_modified
    elsif @property.save
      #this needs to go somewhere else
      #deletes rooms that haven't been edited by user
      @property.rooms.each do |x|
        if x.created_at == x.updated_at
          x.destroy
        end
      end
      #render
      render json: { :property => @property}, status: :created
    else
      render json: { :error => "Unable to find property"}, status: :not_modified
    end
  end

  def destroy
  end

  private
  def new_property?
    # addr = current_user.addresses.find_by(address_params)
    addr = current_user.addresses.where(address_params)
  end

  def address_exists?
    address = current_user.addresses.find_by(address_params)
  end

  def address_params
    params.require(:property).permit(:street_address, :zipcode)
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def edit_property_params
    params.require(:property).permit(:sqft, :lotsize, :totalrooms, :bedrooms,
                                     :bathrooms, :street_address, :zipcode, :city, :state)
  end

  def address_params
    params[:property][:street_address].downcase!
    params.require(:property).permit(:street_address, :zipcode)
  end

  def property_params
    params.require(:property).permit(:street_address, :city, :zipcode, :state)
  end

end