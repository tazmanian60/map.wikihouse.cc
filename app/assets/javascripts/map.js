//= require leaflet.markercluster-src
//= require Leaflet.Instagram.Cluster

document.addEventListener("turbolinks:load", function() {
  if ( $('#map').length > 0) {
    var mapOptions = {
      scrollWheelZoom: !$('#map').hasClass('embedded'),
      minZoom: 3,
      maxZoom: 10
    }
    var map = L.map('map', mapOptions).setView([51.505, -0.09], 3)

    var geojsonLayer = new L.GeoJSON.AJAX("/places.json")
    geojsonLayer.addTo(map)

    L.instagram('https://api.instagram.com/v1/tags/wikihouse/media/recent?access_token=4049407803.79d3ccb.d1b78cc92ebc414389bf720278f87da1').addTo(map)

    L.tileLayer('https://api.mapbox.com/styles/v1/wikihousefoundation/ciu6xn84l001w2hljioetinhk/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoid2lraWhvdXNlZm91bmRhdGlvbiIsImEiOiJjaXU2eG1sNG0wMDFuMnRwaXZjYXoxdzJzIn0.WOHKQ7ExpKD81-DG2-smWg', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
        maxZoom: 18
    }).addTo(map)

    // map.once('focus', function() { map.scrollWheelZoom.enable(); });
  }
})
