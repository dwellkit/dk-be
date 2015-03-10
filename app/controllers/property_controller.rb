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

  private

  def property_params
    params.require(:property).permit(:address, :city, :zip, :state)
  end
end
