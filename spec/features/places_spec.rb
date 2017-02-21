require 'rails_helper'

describe "places" do

  skip "can be added to the map", js: false do

    visit "/"
    click_link "Add a place"
    click_link "Individual"

    fill_in "First name", with: "Bart"
    fill_in "Last name", with: "Simpson"
    fill_in "Role/Job Description", with: "Student"
    fill_in "Email", with: "bart@example.com"
    fill_in "URL", with: "http://example.com"
    fill_in "Your involvement in WikiHouse", with: "helper"

    # fill_in "place_address", with: "Springfield, USA"

    # save_and_open_page

    # these are hidden fields... use JS instead
      fill_in "#place_lat", with: 39.7638163
      fill_in "#place_lng", with: -89.7410425

    fill_in "Notes", with: "some notes"
    click_button "Submit Individual for Review"

    expect(page).to have_content "Thank you"
  end

end
