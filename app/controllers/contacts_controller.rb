class ContactsController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    @contact = Contact.new(contact_params)
    @contact.save!
    if @contact.save
      render json: { :contact => @contact }
    else
      render json: { :messages => @user.errors.full_messages }, status: :unprocessable_entity
    end
  end





  private

  def contact_params
    params.require(:contact).permit(:name, :telephone_number, :email, :url, :notes, :fax_number)
  end

end




