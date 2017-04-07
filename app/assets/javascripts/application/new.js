document.addEventListener("turbolinks:load", function() {
  $("input#place_address").geocomplete({
    map: "#geocomplete-map",
    details: "fieldset",
    detailsAttribute: "data-geo",
    markerOptions: {
      draggable: true
    },
    location: [$("input#place_lat").val(), $("input#place_lng").val()]
  });
});
