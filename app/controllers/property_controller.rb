class PropertyController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
  end

  def add
    @property = Property.create
    @property.users = [current_user]
    if @property.add(property_params) == false
      render json: { :error => "unable to find property"}, status: :not_modified
    elsif @property.save
      render json: { :property => @property}, status: :created
    else
      render json: { :error => "Unable to find property"}, status: :not_modified
    end
  end

  def edit
    binding.pry
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
      render json: { :property => @property}, status: :created
    else
      render json: { :error => "Unable to find property"}, status: :not_modified
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def edit_property_params
    params.require(:property).permit(:sqft, :lotsize, :totalrooms, :bedrooms,
                                     :bathrooms, :street_address, :zipcode, :city, :state)
  end

  def property_params
    params.require(:property).permit(:street_address, :city, :zipcode, :state)
  end
end
