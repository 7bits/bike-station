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

      function update_bikes_pos() {
      $.ajax({
        type: 'GET',
        url: '/api/v1/bikes/locations',
        dataType: 'json',
        success: function(locations) {
          present_bike_ids = [];

          locations.locations.forEach(function(location) {
            present_bike_ids = bikes_overlays.map(function(bike_overlay) {
              return bike_overlay.bike_id;
            });
            if (present_bike_ids.indexOf(location.bike_id) == -1) {
              overlay = map.drawOverlay({
                lat: location.lat,
                lng: location.lng,
                content: '<div class="bike_overlay"/>'
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

                  map.removeOverlay(bike_overlay.overlay);

                  bike_overlay.overlay = map.drawOverlay({
                    lat: location.lat,
                    lng: location.lng,
                    content: '<div class="bike_overlay"/>'
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
              map.removeOverlay(bikes_overlays[bike_id].overlay);
              bikes_overlays.splice(bike_id, 1);
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
