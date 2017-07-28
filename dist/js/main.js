var STEPS, doPan, map, mapOptions, myLatlng, panPath, panQueue, panTo, smoothZoom, zoom;

panTo = function(newLat, newLng) {
  var curLat, curLng, dLat, dLng, i;
  if (panPath.length > 0) {
    panQueue.push([newLat, newLng]);
  } else {
    panPath.push('LAZY SYNCRONIZED LOCK');
    curLat = map.getCenter().lat();
    curLng = map.getCenter().lng();
    dLat = (newLat - curLat) / STEPS;
    dLng = (newLng - curLng) / STEPS;
    i = 0;
    while (i < STEPS) {
      panPath.push([curLat + dLat * i, curLng + dLng * i]);
      i++;
    }
    panPath.push([newLat, newLng]);
    panPath.shift();
    setTimeout(doPan, 20);
  }
};

doPan = function() {
  var next, queued;
  next = panPath.shift();
  if (next !== null) {
    map.panTo(new google.maps.LatLng(next[0], next[1]));
    setTimeout(doPan, 20);
  } else {
    queued = panQueue.shift();
    if (queued !== null) {
      panTo(queued[0], queued[1]);
    } else {
      map.setZoom(zoom);
    }
  }
};

smoothZoom = function(map, max, cnt) {
  var z;
  if (cnt >= max) {
    return;
  } else {
    z = google.maps.event.addListener(map, 'zoom_changed', function(event) {
      google.maps.event.removeListener(z);
      r(map, max, cnt + 1);
    });
    setTimeout((function() {
      map.setZoom(cnt);
    }), 80);
  }
};

if (document.getElementById('map-canvas')) {
  zoom = void 0;
  myLatlng = new google.maps.LatLng(52.525595, 13.393085);
  mapOptions = {
    zoom: 10,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  $('.btn').click(function() {
    var lat, lng;
    zoom = map.getZoom();
    if (zoom > 9) {
      map.setZoom(14);
    }
    lat = $(this).data('lat');
    lng = $(this).data('lng');
    google.maps.event.addListenerOnce(map, 'idle', function() {
      panTo(lat, lng);
    });
  });
  panPath = [];
  panQueue = [];
  STEPS = 100;
}
