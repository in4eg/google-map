# initMap = ->
# 	uluru = 
# 		lat: -25.363
# 		lng: 131.044
# 	map = new (google.maps.Map)(document.getElementById('map-canvas'),
# 		zoom: 4
# 		center: uluru)
# 	marker = new (google.maps.Marker)(
# 		position: uluru
# 		map: map)
# 	return


# google.maps.event.addDomListener window, 'load', initMap



# panTo = (newLat, newLng) ->
#   if panPath.length > 0
#     panQueue.push [
#       newLat
#       newLng
#     ]
#   else
#     panPath.push 'LAZY SYNCRONIZED LOCK'
#     curLat = map.getCenter().lat()
#     curLng = map.getCenter().lng()
#     dLat = (newLat - curLat) / STEPS
#     dLng = (newLng - curLng) / STEPS
#     i = 0
#     while i < STEPS
#       panPath.push [
#         curLat + dLat * i
#         curLng + dLng * i
#       ]
#       i++
#     panPath.push [
#       newLat
#       newLng
#     ]
#     panPath.shift()
#     setTimeout doPan, 20
#   return

# doPan = ->
#   next = panPath.shift()
#   if next != null
#     map.panTo new (google.maps.LatLng)(next[0], next[1])
#     setTimeout doPan, 20
#   else
#     queued = panQueue.shift()
#     if queued != null
#       panTo queued[0], queued[1]
#     else
#       map.setZoom zoom
#   return


# smoothZoom = (map, max, cnt) ->
#   if cnt >= max
#     return
#   else
#     z = google.maps.event.addListener(map, 'zoom_changed', (event) ->
#       google.maps.event.removeListener z
#       r map, max, cnt + 1
#       return
#     )
#     setTimeout (->
#       map.setZoom cnt
#       return
#     ), 3000
#   return

# if document.getElementById('map-canvas')

#   zoom = undefined
#   myLatlng = new (google.maps.LatLng)(52.525595, 13.393085)
#   mapOptions =
#     zoom: 2
#     center: myLatlng
#     mapTypeId: google.maps.MapTypeId.ROADMAP
#   map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
#   marker = new (google.maps.Marker)(
#     position: myLatlng
#     map: map)

#   $('.btn').click ->
#     zoom = map.getZoom()
#     if zoom < 5
#       map.setZoom 18
#     lat = $(this).data('lat')
#     lng = $(this).data('lng')
#     google.maps.event.addListenerOnce map, 'idle', ->
#       panTo lat, lng
#       return
#     return
#   panPath = []
#   panQueue = []
#   STEPS = 1000


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
