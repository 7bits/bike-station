$ ->
  class App.MapRenderer
    default_lat: "54.981629"
    default_lng: "73.368761"
    time_per_update: 5000
    stations_url: '/api/v1/stations/map'
    bikes_locations_url: '/api/v1/bikes/locations'
    bikes_overlays: []
    rented_bikes: []
    info_overlays: []

    bike_overlay_tmpl: HandlebarsTemplates['bike_overlay']
    station_overlay_tmpl: HandlebarsTemplates['station_overlay']
    info_overlay_tmpl: HandlebarsTemplates['info_overlay']



    constructor: (@el) ->
      $(document).on('click', '.js-bike-overlay', @show_info)
      $(document).on('click', '.js-info-overlay', @remove_info)

    show_info: (event) =>
      @remove_info()
      bike_id = $(event.target).data('bike-id')
      overlay = @bikes_overlays.filter (o) -> (o.bike_id == bike_id)
      rent = @rented_bikes.filter (r) -> (r.bike.bike_id == bike_id)
      return if overlay == undefined || rent == undefined || overlay[0] == undefined || rent[0] == undefined
      
      info = {}
      info.lat = overlay[0].lat
      info.lng = overlay[0].lng
      info.user_name = rent[0].user.name
      info.user_surname = rent[0].user.surname
      info.bike_name = rent[0].bike.name
      info.opened_at = rent[0].rent.opened_at

      info_overlay = @map.drawOverlay
        lat: info.lat
        lng: info.lng
        layer: 'overlayMouseTarget',
        verticalAlign: 'bottom',
        verticalOffset: 15,
        content: @info_overlay_tmpl(info)

      @info_overlays.push info_overlay



    remove_info: (event) =>
      @map.removeOverlay(info) for info in @info_overlays
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
              content: @station_overlay_tmpl(station)
        error: (err)->
          console.log(err)

      setInterval =>
        $.ajax
          type: 'GET'
          url: @bikes_locations_url
          dataType: 'json'
          success: (data)=>
            @rented_bikes = data.rented_bikes
            present_bike_ids = 
              (bike_overlay.bike_id for bike_overlay in @bikes_overlays)

            for location in data.locations
              unless location.bike_id in present_bike_ids
                location.mine = (location.bike_id == @station_id)
                
                overlay = @map.drawOverlay
                  lat: location.lat
                  lng: location.lng
                  layer: 'overlayMouseTarget'
                  content: @bike_overlay_tmpl(location)

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
                    content: @bike_overlay_tmpl(location)
                  bike_overlay.lat = location.lat
                  bike_overlay.lng = location.lng

            present_location_ids = (location.bike_id for location in data.locations)
            for bike_id in present_bike_ids
              unless bike_id in present_location_ids
                i = 0

                while(@bikes_overlays[i])
                  if @bikes_overlays[i].bike_id == bike_id
                    @map.removeOverlay(@bikes_overlays[i].overlay)
                    @bikes_overlays.splice(i, 1)    
                  i+=1
                
      , @time_per_update