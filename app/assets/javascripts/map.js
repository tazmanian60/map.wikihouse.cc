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
    var mapbox = L.tileLayer('https://api.mapbox.com/styles/v1/wikihousefoundation/ciu6xn84l001w2hljioetinhk/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoid2lraWhvdXNlZm91bmRhdGlvbiIsImEiOiJjaXU2eG1sNG0wMDFuMnRwaXZjYXoxdzJzIn0.WOHKQ7ExpKD81-DG2-smWg', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
        maxZoom: 18
    })
    mapbox.addTo(map)

    var mapLayerGroups = [];
    // map.once('focus', function() { map.scrollWheelZoom.enable(); });

    var list = ['Individual', 'Organisation', 'Build']
    for (var i = 0; i < list.length; i++) {
      mapLayerGroups[list[i]] = new L.layerGroup();
      mapLayerGroups[list[i]].addTo(map)
    }

    // places layer

    L.Util.ajax("/places.json").then(function(data){
      // var geojsonLayer = new L.GeoJSON.AJAX(data, geoJSONOptions)
      var geojsonLayer = new L.GeoJSON(data, {
        onEachFeature: onEachFeature,
        pointToLayer: function(feature, latlng) {
          var greenIcon = L.icon({
            iconUrl: '/' + feature.properties.amenity + '.png',
            // shadowUrl: 'leaf-shadow.png',
            iconSize:     [20, 30],
            // shadowSize:   [50, 64],
            iconAnchor:   [10, 30],
            // shadowAnchor: [4, 62],
            popupAnchor:  [0, -30]
          });
          return L.marker(latlng, {icon: greenIcon});
        }
      })
    });
    // var geojsonLayer = new L.GeoJSON.AJAX("/places.json", geoJSONOptions)


    function onEachFeature(feature, layer) {
      var lg = mapLayerGroups[feature.properties.amenity];
      if (lg === undefined) {
        lg = new L.layerGroup();
        lg.addTo(map);
        mapLayerGroups[feature.properties.amenity] = lg;
      }
      lg.addLayer(layer);

      console.log(layer)

      if (feature.properties && feature.properties.popupContent) {
        layer.bindPopup("<h1>" + feature.properties.name + "</h1><p>" + feature.properties.description + "</p>");
      }
    }

    // function onEachFilter(feature, layer) {
    //   return true;
    //   // return feature.properties.amenity == "Place";
    // }

    // instagram layer
    var instagram = L.instagram('https://api.instagram.com/v1/tags/wikihouse/media/recent?access_token=4049407803.79d3ccb.d1b78cc92ebc414389bf720278f87da1')
    // instagram.addTo(map)

    var baseLayers = {
      // "Mapbox": mapbox
    };
    var overlays = {
      "Instagram Photos": instagram,
      "Individuals": mapLayerGroups['Individual'],
      "Organisations": mapLayerGroups['Organisation'],
      "Builds": mapLayerGroups['Build']
    };
    L.control.layers(baseLayers, overlays).addTo(map);
  }

})
