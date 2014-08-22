(function($){
  var server_error_handler = function() {
    console.error('Something went wrong.');
  }

  window.Map = {
    render: function(station_lat, station_lng, station_id) {
      update_bikes_pos();

      var map = new GMaps({
        el: "#map",
        lat: station_lat || "54.981629",
        lng: station_lng || "73.368761"
      });

      var bikes_overlays = [];
      var rented_bikes = [];
      var info_overlays = [];

      $.remove_info = function() {
        info_overlays.forEach(function(info_overlay) {
          map.removeOverlay(info_overlay);
        });
        info_overlays = [];
      }

      $.show_info = function(bike_id) {
        $.remove_info();
        bike_lat = 0;
        bike_lng = 0;
        bike_name = "";
        user_name = "";
        user_surname = "";
        openned_at = "";

        bikes_overlays.forEach(function(overlay) {
          if (overlay.bike_id == bike_id) {
            bike_lat = overlay.lat;
            bike_lng = overlay.lng;
          }
        });
        rented_bikes.forEach(function(rented_bike) {
          if (rented_bike.bike.bike_id == bike_id) {
            user_name = rented_bike.user.name;
            user_surname = rented_bike.user.surname;
            bike_name = rented_bike.bike.name;
            openned_at = rented_bike.rent.openned_at;
          }
        });
        // console.log(bike_id, bike_lat, bike_lng, bike_name, user_name, user_surname);

        info_overlay = map.drawOverlay({
          lat: bike_lat,
          lng: bike_lng,
          layer: 'overlayMouseTarget',
          verticalAlign: 'bottom',
          verticalOffset: 15,
          content: '<div class="bike_info" onClick="$.remove_info()"><p>' + bike_name + '</p><p>' + user_name + ' ' + user_surname + '</p><p>' + openned_at + '</p></div>'
        });

        info_overlays.push(info_overlay);
      }

      function update_bikes_pos() {

        $.ajax({
          type: 'GET',
          url: '/api/v1/bikes/locations',
          dataType: 'json',
          success: function(locations) {
            rented_bikes = locations.rented_bikes;
            present_bike_ids = [];

            present_bike_ids = bikes_overlays.map(function(bike_overlay) {
              return bike_overlay.bike_id;
            });
            locations.locations.forEach(function(location) {
              if (present_bike_ids.indexOf(location.bike_id) == -1) {
                content = '<div class="other_bike_overlay" onClick="$.show_info(' + location.bike_id + ')"/>'
                if (location.station_id == station_id) {
                  content = '<div class="my_bike_overlay" onClick="$.show_info(' + location.bike_id + ')"/>'
                };
                overlay = map.drawOverlay({
                  lat: location.lat,
                  lng: location.lng,
                  layer: 'overlayMouseTarget',
                  content: content
                });
                bikes_overlays.push({
                  bike_id: location.bike_id,
                  lat: location.lat,
                  lng: location.lng,
                  overlay: overlay
                });
              }
              bikes_overlays.forEach(function(bike_overlay) {
                if (bike_overlay.bike_id == location.bike_id) {

                  if ( bike_overlay.lat != location.lat
                    || bike_overlay.lng != location.lng) {

                    content = '<div class="other_bike_overlay" onClick="$.show_info(' + location.bike_id + ')"/>'
                    if (location.station_id == station_id) {
                      content = '<div class="my_bike_overlay" onClick="$.show_info(' + location.bike_id + ')"/>'
                    };

                    map.removeOverlay(bike_overlay.overlay);

                    bike_overlay.overlay = map.drawOverlay({
                      lat: location.lat,
                      lng: location.lng,
                      layer: 'overlayMouseTarget',
                      content: content
                    });
                    bike_overlay.lat = location.lat;
                    bike_overlay.lng = location.lng;
                  }
                }
              });
            });
            present_location_ids = locations.locations.map(function(location) {
              return location.bike_id;
            });
            present_bike_ids.forEach(function(bike_id) {
              if (present_location_ids.indexOf(bike_id) == -1) {
                var index = -1;
                for (var i = bikes_overlays.length - 1; i >= 0; i--) {
                  if (bikes_overlays[i].bike_id == bike_id) {
                    index = i;
                    break;
                  }
                }
                if (index >= 0) {
                  map.removeOverlay(bikes_overlays[index].overlay);
                }
                bikes_overlays.splice(index, 1);
              }
            });
          }
        });
      }

      var timer = setInterval(update_bikes_pos, 5000);

      $.ajax({
        type: 'GET',
        url: '/api/v1/stations/map',
        dataType: 'json',
        success: function(data) {
          if (data) {
            for (var i = 0, len = data.stations.length; i < len; i++){
              var station = data.stations[i];
              if (station.lat != undefined && station.lng != undefined){
                map.drawOverlay({
                  lat: station.lat,
                  lng: station.lng,
                  title: station.name,
                  layer: 'overlayMouseTarget',
                  content: '<div class="station_overlay" title="' + station.name + '"> <p>' + station.bikes_count + '</p> </div>'
                });
              }
            }
          }
        },
        error: server_error_handler,
      });
    }
  }
})(jQuery);
