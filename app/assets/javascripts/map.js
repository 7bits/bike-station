(function($){
  var server_error_handler = function() {
    console.error('Something went wrong.');
  }

  var renderMarkers = function(stations) {
    console.log(stations);
  }

  window.Map = {
    start: function() {
      var map = new L.Map('map', {center: new L.LatLng(55.00, 73.5), zoom: 13});
      var googleLayer = new L.Google('ROADMAP');
      map.addLayer(googleLayer);
      $.ajax({
        type: 'GET',
        url: 'api/v1/stations',
        dataType: 'json',
        success: function(data) {
          if (data) {
            console.log(data);
            stations = data.stations;
            renderMarkers(stations);
          }
        },
        error: server_error_handler,
      });
    }
  }
})(jQuery);
