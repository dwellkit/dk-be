class WarrantiesController < ApplicationController


  def contact
    @warranty = Warranty.find(params[:id])
    binding.pry
    @contact = Contact.find(params[:id])
    @contact.update_attribute(:reachable, @warranty)
    binding.pry
  end


end
