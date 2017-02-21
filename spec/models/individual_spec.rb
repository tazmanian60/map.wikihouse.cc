require 'rails_helper'

RSpec.describe Individual, type: :model do

  it "uses the name as to_s" do
    homer = Individual.new(first_name: "Homer", last_name: "Simpson")
    expect(homer.to_s).to eq("Homer Simpson")
  end

end
