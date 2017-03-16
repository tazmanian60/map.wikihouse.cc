document.addEventListener("turbolinks:load", function() {
  var options = {
    map: "#geocomplete-map",
    markerOptions: {
      draggable: true
    }
  };

  function setPlace(location) {
    $("#place_lat").val(location.lat());
    $("#place_lng").val(location.lng());
  }

  $("input#place_address").geocomplete(options)
    .bind("geocode:result", function(event, result){
      setPlace(result.geometry.location)
    })
    .bind("geocode:dragged", function(event, latLng){
      setPlace(latLng)
    });
});
