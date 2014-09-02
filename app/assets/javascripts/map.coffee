$ ->
  class App.MapRenderer
    default_lat: "54.981629"
    default_lng: "73.368761"
    time_per_update: 5000
    stations_url: '/api/v1/stations/map'
    bikes_locations_url: '/api/v1/bikes/locations'

    other_bike_overlay: HandlebarsTemplates['other_bike_overlay']
    my_bike_overlay: HandlebarsTemplates['my_bike_overlay']
    station_overlay: HandlebarsTemplates['station_overlay']

    constructor: (@el) ->
      @bikes_overlays = []
      @rented_bikes = []
      @info_overlays = []

    render: (station_lat, station_lng, station_id) =>
      map = new GMaps
        el: @el
        lat: station_lat || @default_lat
        lng: station_lng || @default_lng

      #setInterval(update_bikes_pos, @time_per_update)

      $.ajax
        type: 'GET'
        url: @stations_url
        dataType: 'json'
        success: (data) =>
          return unless data
          for station in data.stations
            continue unless station.lat && station.lng
            map.drawOverlay
              lat: station.lat
              lng: station.lng
              title: station.name
              layer: 'overlayMouseTarget'
              content: @station_overlay(station)
        error: (err)->
          console.log(err)

      update_bikes_pos = ()=>
        $.ajax
          type: 'GET'
          url: @bikes_locations_url
          dataType: 'json'
          success: (data)=>
            rented_bikes = locations.rented_bikes
            present_bike_ids = 
              (bike_overlay.bike_id for bike_overlay in @bikes_overlays)

            for location in data.locations
              if location.bike_id not in present_bike_ids
                console.log(location.bike_id)


 



