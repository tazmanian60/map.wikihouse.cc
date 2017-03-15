require 'rails_helper'

RSpec.describe Place, type: :model do

  describe "state" do
    it "has a default awaiting_review state" do
      expect(Place.new.current_state).to eq('awaiting_review')
    end
  end

  it "has safe_latlng method to lessen the accuracy on the map" do
    place = Place.new(lat: 1.111111111, lng: 2.2222222222)
    expect(place.safe_latlng).to eq(['1.11', '2.22'])
  end

end
