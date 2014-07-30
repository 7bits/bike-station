class RentsController < ApplicationController
  def index
    @form = RentInput.new
  end

  def open
    @form = RentInput.new open_rent_params
    
    if @form.valid?
      redirect_to rents_path
    else
      render :index
    end
  end

  def close

  end

  private
  def open_rent_params
    params.require(:rent_input)
  end
end
