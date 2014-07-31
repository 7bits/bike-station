class RentsController < ApplicationController
  def index
    @form = RentInput.new
    @rents = Rent.openned
  end

  def show
    @rent = Rent.find(params[:id])
  end

  def open
    @form = RentInput.new open_rent_params
    service = RentService.new
    
    if @form.valid?
      service.open_rent(@form)
      redirect_to rents_path
    else
      @rents = Rent.openned # TODO: only for rendering errros. Replase method with ajax and remove it
      render :index
    end
  end

  def close
    service = RentService.new
    rent = service.close_rent params[:id]
    if rent.nil?
      flash[:danger] = "Can't close rent."
      redirect_to rents_path
    else
      redirect_to rent
    end
  end

  private
  def open_rent_params
    params.require(:rent_input)
  end
end
