(function($){
  var server_error_handler = function() {
    console.error('Something went wrong.');
  }

  window.Map = {
    render: function(station_lat, station_lng) {
      var map = new GMaps({
        el: "#map",
        lat: station_lat || "54.981629",
        lng: station_lng || "73.368761"
      });

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
