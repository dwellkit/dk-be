class PropertiesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_property, only: [:edit, :reimport, :destroy, :show, :edit, :update, :add_image, :show_images]
  before_action :set_property_pic, only: [:pic]


  def index
    if @properties = current_user.properties
      render json: { :properties => @properties }, status: :ok
    else
      render json: { :error => "Unable to find property"}, status: :not_modified
    end
  end

  def show
    if @property
      render "property/index.json.jbuilder", status: :ok
    end
  end

  def create
    parsed_location = StreetAddress::US.parse(address_params[:address])
    @address = Address.new
    @address.add_location( address_params )
    if @address.save
      @property = Property.new
      @address.property = @property
      @property.users = [current_user]
      if @property.create_from_zillow!( parsed_location ) == false
        render json: { :error => "unable to find property" }, status: :not_modified
      elsif @property.save && @address.save
        @rooms = @property.rooms.all
        render "property/index.json.jbuilder", status: :ok
      else
        render json: { :error => @property.errors.full_messages}, status: :not_acceptable
      end
    else
      render json: { :error => @address.errors.full_messages}, status: :not_acceptable
    end
  end

  def update
    if @property.update( edit_property_params )
      render json: { :property => @property}, status: :created
    else
      render json: { :error => "Unable to edit property"}, status: :not_modified
    end
  end

  def reimport
    parsed_location = StreetAddress::US.parse(address_params[:address])
    if @property.create_from_zillow!(parsed_location) == false
      render json: { :error => "unable to find property"}, status: :not_modified
    elsif @property.save
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
    if @property.destroy!
      render json: { :message => 'Your property has been removed' }
    else
      render json: { :error => 'Property could not be deleted' }
    end
  end


  def pic
    if @property.update( pic_params )
      render json: { :pic => @property.profile.url(:medium)}
    else
      render json: { :error => "terrible terrible terrible try the dater"}, status: :not_modified
    end
  end

  def add_image
    @picture = Picture.create( image_params )
    @picture.update(:property_id => @property.id)
    if @picture.update_attribute(:picturable, @property)
      render json: { :image => @picture.image.url(:thumb) }
    else
      render json: { :error => "Couldn't add image" }, status: :not_modified
    end
  end

  def show_images
    if @pictures = @property.pictures.all
      render json: { :images => @pictures }
    else
      render json: { :error => "Couldn't find the Property's pictures"}
    end
  end


  private
    def image_params
      params.require(:file).permit(:image)
    end

    def pic_params
      params.require(:property).permit(:profile)
    end

    def address_params
      params.require(:property).permit(:address)
    end

    def set_property
      @property = Property.find(params[:id])
    end

    def set_property_pic
      @property = Property.find(params[:property_id])
    end

    def edit_property_params
      params.require(:property).permit(:sqft, :lotsize, :totalrooms, :bedrooms,
                                       :bathrooms, :actual_rooms_count)
    end

    def property_params
      params.require(:property).permit(:street_address, :city, :zipcode, :state)
    end
end
