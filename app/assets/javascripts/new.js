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
      // $.log("Result: " + result.formatted_address);
      setPlace(result.geometry.location)
    })
    .bind("geocode:error", function(event, status){
      // $.log("ERROR: " + status);
    })
    .bind("geocode:multiple", function(event, results){
      // $.log("Multiple: " + results.length + " results found");
    })
    .bind("geocode:dragged", function(event, latLng){
      setPlace(latLng)
    });
});
