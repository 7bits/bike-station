$ ->
  class App.MapRenderer
    default_lat: "54.981629"
    default_lng: "73.368761"
    time_per_update: 5000
    stations_url: '/api/v1/stations/map'
    bikes_locations_url: '/api/v1/bikes/locations'

    bike_overlay: HandlebarsTemplates['bike_overlay']
    station_overlay: HandlebarsTemplates['station_overlay']

    constructor: (@el) ->
      @bikes_overlays = []
      @rented_bikes = []
      @info_overlays = []

    render: (station_lat, station_lng, station_id) =>
      @map = new GMaps
        el: @el
        lat: station_lat || @default_lat
        lng: station_lng || @default_lng

      $.ajax
        type: 'GET'
        url: @stations_url
        dataType: 'json'
        success: (data) =>
          return unless data
          for station in data.stations
            continue unless station.lat && station.lng
            @map.drawOverlay
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
            console.log(data)
            rented_bikes = data.rented_bikes
            present_bike_ids = 
              (bike_overlay.bike_id for bike_overlay in @bikes_overlays)

            for location in data.locations
              unless location.bike_id in present_bike_ids
                console.log(location.bike_id)
                location.mine = (location.bike_id == @station_id)
                
                overlay = @map.drawOverlay
                  lat: location.lat
                  lng: location.lng
                  layer: 'overlayMouseTarget'
                  content: @bike_overlay(location)

                @bikes_overlays.push
                  bike_id: location.bike_id
                  lat: location.lat
                  lng: location.lng
                  overlay: overlay

              for bike_overlay in @bikes_overlays
                if bike_overlay.lat != location.lat || bike_overlay.lng != location.lng
                  @map.removeOverlay(bike_overlay.overlay)

                  bike_overlay.overlay = @map.drawOverlay
                    lat: location.lat
                    lng: location.lng
                    layer: 'overlayMouseTarget'
                    content: @bike_overlay(location)
                  bike_overlay.lat = location.lat
                  bike_overlay.lng = location.lng

            present_location_ids = (location.id for location in data.locations)
            for bike_id in present_bike_ids
              unless bike_id in present_location_ids
                i = 0
                index = -1
                
                for bike_overlay in @bikes_overlays
                  i += 1
                  if bike_overlay.bike_id == bike_id
                    index = i 
                    break
                
                if index >= 0
                  map.removeOverlay(@bikes_overlays[index].overlay)

                @bikes_overlays.splice(index, 1)

      setInterval update_bikes_pos, @time_per_update


 



