class PicturesController < ApplicationController
  before_action :authenticate_user_from_token!

  def destroy
    @picture = set_picture
    if @picture.destroy!
      render json: { :message => 'The selected picutre has been deleted.'}, status: :ok
    else
      render json: {:error => 'Could not delete the selected picture'}, status: :not_modified
    end
  end


  private

  def set_picture
    @picture = Picture.find(params[:xid])
  end

end
