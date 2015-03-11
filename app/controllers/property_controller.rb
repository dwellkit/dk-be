class PropertyController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_property, only: [:edit, :reimport, :destroy]

  def index
  end

  def add
    @property = Property.create
    @property.users = [current_user]
    if @property.add(property_params) == false
      render json: { :error => "unable to find property"}, status: :not_modified
    elsif @property.save
      #this should go somewhere else but okay for now
      1.upto(@property.bedrooms.to_i) do |x|
        @property.rooms.create(:name => "Bedroom #{x}")
      end
      1.upto(@property.bathrooms.to_i) do |x|
        @property.rooms.create(:name => "Bathroom #{x}")
      end

      # Make location things look nice

      street = property_params[:street_address].gsub('+', ' ')
      street = street.split.map(&:capitalize).join(' ')
      city = property_params[:city].split.map(&:capitalize).join(' ')
      state = property_params[:state].upcase

      @address = Address.new(:property_id => @property.id)
      @address.street_address = street
      @address.city = city
      @address.state = state
      @address.zipcode = property_params[:zipcode]
      @address.save

      @rooms = @property.rooms.all
      # render json: { :property => @property, :rooms => @rooms }, status: :created
      render "property/index.json.jbuilder", status: :ok
    else
      render json: { :error => "Unable to find property"}, status: :not_modified
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
