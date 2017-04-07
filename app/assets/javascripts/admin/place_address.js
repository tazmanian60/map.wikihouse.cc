document.addEventListener("turbolinks:load", function() {
  $(".place-address").each(function() {
    var address = $(this);

    if (address.find(".place-map").length) {
      return
    }

    var coords = [address.data("lat"), address.data("lng")];

    var map = L.map($("<div>", { class: "place-map" }).appendTo(address)[0]);
    mapTiles().addTo(map)
    L.marker([address.data("lat"), address.data("lng")]).addTo(map);
    map.setView(coords, 13)
  })
})
