json.array!(@places) do |place|
  json.type 'Feature'

  json.properties do
    json.name place.name
    json.amenity place.class.to_s
    json.description place.description
  end

  json.geometry do
    json.type "Point"
    json.coordinates [place.lng,place.lat]
  end
end
