class RentsController < ApplicationController
  before_action :find_station

  def closing
    @rents = Rent.openned
  end

  def show
    @rent = Rent.find(params[:id])
  end

  def opening
    @form = RentInput.new
  end

  def open
    @form = RentInput.new open_rent_params
    service = RentService.new
    push_sender = PushSenderFactory.build
    
    if @form.valid?
      rent = service.open_rent(@form, @station)
      rent_presenter = RentPresenter.new(rent, :new)
      push_sender.send_notification_to(rent.bike, rent_presenter.wrap)
      redirect_to @station
    else
      @rents = Rent.openned # TODO: only for rendering errros. Replase method with ajax and remove it
      render :closing
    end
  end

  def close
    service = RentService.new
    push_sender = PushSenderFactory.build

    rent = service.close_rent(params[:id], @station)
    if rent.nil?
      flash[:danger] = "Can't close rent."
      redirect_to station_rents_path(@station)
    else
      rent_presenter = RentPresenter.new(rent, :close)
      push_sender.send_notification_to(rent.bike, rent_presenter.wrap)
      redirect_to station_rent_path(@station, rent)
    end
  end

  private
  def open_rent_params
    params.require(:rent_input)
  end

  def find_station
    @station = Station.find params[:station_id]
  end
end
