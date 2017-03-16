require 'rails_helper'

describe "places" do

  example "adding a contributor" do
    visit "/"
    click_link "Add a place"
    click_link "Contributor"

    fill_in "Name", with: "Bart Simpson"
    fill_in "URL", with: "http://example.com"
    fill_in "Your involvement in WikiHouse", with: "helper"
    fill_in "Address", with: "Springfield, USA"

    page.execute_script "$('#place_address').trigger('geocode')"
    expect(page).to have_selector("#place_lat", visible: false) { |field|
      field.value.present?
    }

    click_button "Submit"
    expect(page).to have_content("Thanks")

    place = Place.order("created_at desc").first
    visit admin_reviews_path

    click_button "Accept"
    expect(place.reload).to be_accepted

    visit "/"
    find("[title='Bart Simpson']").click
  end

end
