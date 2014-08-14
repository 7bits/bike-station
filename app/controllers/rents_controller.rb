class RentsController < ApplicationController
  before_action :find_station

  def closing
    @rents = Rent.openned

    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new('Close rent', close_station_rents_path(@station), 'active')
    ]
  end

  def show
    @rent = Rent.find(params[:id])
  end

  def opening
    @form = RentInput.new

    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new('Open rent', open_station_rents_path(@station), 'active')
    ]
  end

  def open
    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new('Open rent', open_station_rents_path(@station), 'active')
    ]

    @form = RentInput.new open_rent_params
    service = RentService.new
    push_sender = PushSenderFactory.build
    
    if @form.valid?
      rent = service.open_rent(@form, @station)
      rent_presenter = RentPresenter.new(rent, 0, :new)
      push_sender.send_notification_to(rent.bike, rent_presenter.wrap)
      redirect_to @station
    else
      @rents = Rent.openned # TODO: only for rendering errros. Replase method with ajax and remove it
      render :opening
    end
  end

  def close
    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new('Close rent', close_station_rents_path(@station), 'active')
    ]

    service = RentService.new
    push_sender = PushSenderFactory.build

    rent = service.close_rent(params[:id], @station)
    if rent.nil?
      flash[:danger] = "Can't close rent."
      redirect_to station_rents_path(@station)
    else
      cost_counter = CostCounter.new
      rent_time = cost_counter.calculate_time(rent.openned_at, rent.closed_at)
      cost = cost_counter.calculate_cost(rent.rate.price, rent_time)
      rent_presenter = RentPresenter.new(rent, cost, :close)
      push_sender.send_notification_to(rent.bike, rent_presenter.wrap)
      redirect_to history_station_path(@station)
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
