class BillsController < ApplicationController
  before_action :set_bills, only: [:index]
  before_action :set_property, only: [:index]

  def index
    if @bills
      render json: { :bills => @bills }, status: :ok
    else
      render json: { :error => "Unable to find bills"}
    end
  end


  private

    def bill_params
      params.require(:bill).permit(:month, :bill_type, :amount_due)
    end

    def set_bills
      @property = Property.find(params[:property_id])
      @bills = @property.bills.all
    end

    def set_property
      @property = Property.find(params[:property_id])
    end

end
