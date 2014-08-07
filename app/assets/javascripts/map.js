(function($){
  var server_error_handler = function() {
    console.error('Something went wrong.');
  }

  window.Map = {
    render: function() {
      var map = new GMaps({
        el: "#map",
        lat: "54.981629",
        lng: "73.368761"
      });
      var markers_pool = [];

      $.ajax({
        type: 'GET',
        url: 'api/v1/stations',
        dataType: 'json',
        success: function(data) {
          if (data) {
            for (var i = 0, len = data.stations.length; i < len; i++){
              var station = data.stations[i];
              if (station.lat != undefined && station.lng != undefined){
                markers_pool.push({
                  lat: station.lat,
                  lng: station.lng,
                  title: station.name
                });
              }
            }
            console.log(markers_pool);
            map.addMarkers(markers_pool);
          }
        },
        error: server_error_handler,
      });
    }
  }
})(jQuery);
