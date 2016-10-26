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


    // places layer

    var geoJSONOptions = {
      onEachFeature: onEachFeature,
      filter: onEachFilter
    }

    var geojsonLayer = new L.GeoJSON.AJAX("/places.json", geoJSONOptions)

    // var places = geojsonLayer.refilter(function(feature){
    //     return feature.properties.amenity === "Place";
    // });

    function onEachFeature(feature, layer) {
      var lg = mapLayerGroups[feature.properties.amenity];
      if (lg === undefined) {
        lg = new L.layerGroup();
        //add the layer to the map
        lg.addTo(map);
        //store layer
        mapLayerGroups[feature.properties.amenity] = lg;
      }
      lg.addLayer(layer);

      if (feature.properties && feature.properties.popupContent) {
        layer.bindPopup(feature.properties.popupContent);
      }
    }

    function onEachFilter(feature, layer) {
      return true;
      // return feature.properties.amenity == "Place";
    }


    // instagram layer
    var instagram = L.instagram('https://api.instagram.com/v1/tags/wikihouse/media/recent?access_token=4049407803.79d3ccb.d1b78cc92ebc414389bf720278f87da1')
    instagram.addTo(map)


    var baseLayers = {
      // "Mapbox": mapbox
    };
    var overlays = {
      "Instagram Photos": instagram,
      "Places": geojsonLayer
    };
    L.control.layers(baseLayers, overlays).addTo(map);
  }

})
