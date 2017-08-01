var initMap;

initMap = function() {
  var i, map, marker, myLatlng;
  myLatlng = {
    lat: 59.9342802,
    lng: 30.3350986
  };
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 1,
    mapTypeId: 'satellite',
    center: myLatlng
  });
  marker = new google.maps.Marker({
    position: myLatlng,
    map: map,
    title: 'My Place'
  });
  i = map.getZoom();
  console.log(i);
  $('#btn').on('click', function() {
    var timerId;
    timerId = setInterval(((function(_this) {
      return function() {
        var zoom;
        i++;
        map.setZoom(i);
        console.log(i);
        zoom = $('#map').data('zoom');
        if (i === zoom) {
          console.log('zoom' + zoom);
          clearInterval(timerId);
          i = 0;
        }
      };
    })(this)), 100);
    return map.setCenter(marker.getPosition());
  });
};

google.maps.event.addDomListener(window, 'load', initMap);
