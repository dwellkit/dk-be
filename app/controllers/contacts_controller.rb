class ContactsController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    @contact = Contact.create
  end





  private

  def contact_params
    params.require(:contact).permit(:name, :telephone_number, :email, :url, :notes, :fax_number)
  end

end




