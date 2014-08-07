class Api::V1::StationsController < ApplicationController
  def get_stations
    render json: {stations: [
      {
        id: 1, 
        lat: 54.968094, 
        lng: 73.378906, 
        name: "Иртышская набережная",
        bikes_count: 4
      },
      {
        id: 2,
        lat: 54.98253,
        lng: 73.370534,
        name: "Омская крепость",
        bikes_count: 2
      }
    ]}, status: :ok
  end
end
