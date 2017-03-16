//= require leaflet.markercluster-src
//= require Leaflet.Instagram.Cluster

function mapTiles() {
  return L.tileLayer(
    'https://api.mapbox.com/styles/v1/wikihousefoundation/ciu6xn84l001w2hljioetinhk/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoid2lraWhvdXNlZm91bmRhdGlvbiIsImEiOiJjaXU2eG1sNG0wMDFuMnRwaXZjYXoxdzJzIn0.WOHKQ7ExpKD81-DG2-smWg',
    {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: 18
    }
  )
}

document.addEventListener("turbolinks:load", function() {
  if ( $('#map').length > 0) {
    var mapOptions = {
      scrollWheelZoom: !$('#map').hasClass('embedded'),
      minZoom: 3,
      maxZoom: 10
    }
    var map = L.map('map', mapOptions).setView([51.505, -0.09], 3)
    mapTiles().addTo(map)

    var mapLayerGroups = [];

    var list = ['Contributor', 'Build']
    for (var i = 0; i < list.length; i++) {
      mapLayerGroups[list[i]] = new L.layerGroup();
      mapLayerGroups[list[i]].addTo(map)
    }

    L.Util.ajax("/places.json").then(function(data){
      var geojsonLayer = new L.GeoJSON(data, {
        onEachFeature: onEachFeature,
        pointToLayer: function(feature, latlng) {
          var icon = L.VectorMarkers.icon({
            icon: feature.properties.icon,
            iconSize: [20, 33],
            iconAnchor: [10, 33],
            popupAnchor: [0, -33],
            shadowSize: [20, 33],
            shadowAnchor: [20, 22],
            className: "vector-marker marker-" + feature.properties.amenity,
          });

          return L.marker(latlng, {
            icon: icon,
            title: feature.properties.name,
          });
        }
      })
    });

    function onEachFeature(feature, layer) {
      var lg = mapLayerGroups[feature.properties.amenity];
      if (lg === undefined) {
        lg = new L.layerGroup();
        lg.addTo(map);
        mapLayerGroups[feature.properties.amenity] = lg;
      }
      lg.addLayer(layer);

      if (feature.properties && feature.properties.name) {
        var str = "<h1>" + feature.properties.name + "</h1>"
        if (feature.properties.description) {
          str += "<p>" + feature.properties.description.autoLink() + "</p>";
        }
        layer.bindPopup(str);
      }
    }

    var instagram = L.instagram('https://api.instagram.com/v1/tags/wikihouse/media/recent?access_token=4049407803.79d3ccb.d1b78cc92ebc414389bf720278f87da1')

    var overlays = {
      "Instagram Photos": instagram,
      "Contributors": mapLayerGroups['Contributor'],
      "Builds": mapLayerGroups['Build']
    };

    L.control.layers({}, overlays).addTo(map);
  }

})
