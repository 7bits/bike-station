class Api::V1::StationsController < ApplicationController
  def get_stations
    render json: {stations: [
      {
        id: 1, 
        latitude: 0.54968094, 
        longitude: 0.73378906, 
        name: "Иртышская набережная",
        bikes_count: 4
      },
      {
        id: 2,
        latitude: 0.5498253,
        longitude: 0.73370534,
        name: "Омская крепость",
        bikes_count: 2
      }
    ]}, status: :ok
  end
end
