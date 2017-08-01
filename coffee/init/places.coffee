init = ->
  map = new (google.maps.Map)(document.getElementById('map'),
    zoom: 15
    scrollwheel: false
    center: myLatLng)
  markerImage = new (google.maps.MarkerImage)('img/map-marker.png')
  marker = new (google.maps.Marker)(
    position: myLatLng
    icon: markerImage
    map: map)
  infowindow = new (google.maps.InfoWindow)
  windowContent = mapPin.name
  google.maps.event.addListener marker, 'click', ->
    infowindow.setContent windowContent
    infowindow.open map, this
    return
  return

callback = (results, status) ->
  if status == google.maps.places.PlacesServiceStatus.OK
    i = 0
    while i < results.length
      createMarker results[i]
      i++
  return

createMarker = (place) ->
  marker = new (google.maps.Marker)(
    map: map
    position: place.geometry.location)
  markers.push marker
  google.maps.event.addListener marker, 'click', ->
    infowindow.setContent place.name
    infowindow.open map, this
    return
  return

setMapOnAll = (map) ->
  i = 0
  while i < markers.length
    markers[i].setMap null
    i++
  return

$(document).ready ->
  google.maps.event.addDomListener window, 'load', init
  return
mapPin = 
  'center': true
  'name': 'Miami Beach.Sunny Isles Beach 33131, FL, USA'
  'description': 'Miami Beach, FL, USA'
  'address': 'Miami Beach, FL, USA'
  'geometry': 'location':
    'lat': 25.763292138174872
    'lng': -80.19253071900195
myLatLng = 
  lat: mapPin.geometry.location.lat
  lng: mapPin.geometry.location.lng
map = undefined
markers = []
$('.point').click (e) ->
  e.preventDefault()
  $(this).addClass('active').siblings().removeClass 'active'
  setMapOnAll map
  category = $(this).attr('data-category')
  service = new (google.maps.places.PlacesService)(map)
  service.nearbySearch {
    location: myLatLng
    radius: 500
    types: [ category ]
  }, callback
  return
