

initMap = ->
  myLatlng = 
    lat: 59.9342802
    lng: 30.3350986
  map = new (google.maps.Map)(document.getElementById('map'),
    zoom: 1
    mapTypeId: 'satellite'
    center: myLatlng)
  marker = new (google.maps.Marker)(
    position: myLatlng
    map: map
    title: 'My Place')


  # console.log map.getZoom()

  i = map.getZoom()
  console.log i



  $('#btn').on 'click', ->
    timerId = setInterval((=>
      i++
      
      map.setZoom(i);
      console.log i
      # console.log $('#map').data('zoom')
      zoom = $('#map').data('zoom')

      if i is zoom
        console.log 'zoom' + zoom
        clearInterval timerId
        i = 0
      return
      
    ), 100)

    map.setCenter marker.getPosition()
  return


google.maps.event.addDomListener window, 'load', initMap
