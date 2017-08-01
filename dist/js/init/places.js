var callback, createMarker, init, map, mapPin, markers, myLatLng, setMapOnAll;

init = function() {
  var infowindow, map, marker, markerImage, windowContent;
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    scrollwheel: false,
    center: myLatLng
  });
  markerImage = new google.maps.MarkerImage('img/map-marker.png');
  marker = new google.maps.Marker({
    position: myLatLng,
    icon: markerImage,
    map: map
  });
  infowindow = new google.maps.InfoWindow;
  windowContent = mapPin.name;
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(windowContent);
    infowindow.open(map, this);
  });
};

callback = function(results, status) {
  var i;
  if (status === google.maps.places.PlacesServiceStatus.OK) {
    i = 0;
    while (i < results.length) {
      createMarker(results[i]);
      i++;
    }
  }
};

createMarker = function(place) {
  var marker;
  marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });
  markers.push(marker);
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
  });
};

setMapOnAll = function(map) {
  var i;
  i = 0;
  while (i < markers.length) {
    markers[i].setMap(null);
    i++;
  }
};

$(document).ready(function() {
  google.maps.event.addDomListener(window, 'load', init);
});

mapPin = {
  'center': true,
  'name': 'Miami Beach.Sunny Isles Beach 33131, FL, USA',
  'description': 'Miami Beach, FL, USA',
  'address': 'Miami Beach, FL, USA',
  'geometry': {
    'location': {
      'lat': 25.763292138174872,
      'lng': -80.19253071900195
    }
  }
};

myLatLng = {
  lat: mapPin.geometry.location.lat,
  lng: mapPin.geometry.location.lng
};

map = void 0;

markers = [];

$('.point').click(function(e) {
  var category, service;
  e.preventDefault();
  $(this).addClass('active').siblings().removeClass('active');
  setMapOnAll(map);
  category = $(this).attr('data-category');
  service = new google.maps.places.PlacesService(map);
  service.nearbySearch({
    location: myLatLng,
    radius: 500,
    types: [category]
  }, callback);
});
