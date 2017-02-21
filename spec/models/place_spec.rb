require 'rails_helper'

RSpec.describe Place, type: :model do

  describe "state" do
    it "has a default awaiting_review state" do
      expect(Place.new.current_state).to eq('awaiting_review')
    end

    it "can be accepted from awaiting_review"

    it "can be rejected from awaiting_review"
  end

  it "has safe_latlng method to lessen the accuracy on the map" do
    place = Place.new(lat: 1.111111111, lng: 2.2222222222)
    expect(place.safe_latlng).to eq(['1.11', '2.22'])
  end

end


[Build, Individual, Organisation].each do |klass|

  RSpec.describe klass, type: :model do

    it "is a subclass of Place" do
      expect(klass.superclass).to eq(Place)
    end

    it "shares Place's pundit policy" do
      expect(klass.policy_class).to eq(PlacePolicy)
    end

  end

end
