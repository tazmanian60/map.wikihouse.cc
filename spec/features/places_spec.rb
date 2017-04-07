require 'rails_helper'

describe "places" do

  example "adding a contributor" do
    open_form "Contributor"

    fill_in "Name", with: "Bart Simpson"
    fill_in "Bio", with: "Hello, I'm Bart"
    fill_in "Links", with: "http://example.com"
    attach_file "Image", Rails.root.join("app/assets/images/wikihouse-logo.svg")
    fill_in_address "Springfield, USA"

    submit_form
    accept_submission

    view_map

    open_place("Bart Simpson") do
      expect(page).to have_content("Hello, I’m Bart")
      expect(page).to have_link("http://example.com")
      expect(page).to have_selector("img")
    end
  end

  example "adding a build" do
    open_form "Build"

    fill_in "Project name", with: "Farmhouse"
    fill_in "Description", with: "A great farmhouse"
    select "Complete", from: "Stage"
    fill_in "Core contributors", with: "Rose, Blake"
    fill_in "Links", with: "http://example.com"
    attach_file "Image", Rails.root.join("app/assets/images/wikihouse-logo.svg")
    fill_in_address "Slough, UK"

    submit_form
    accept_submission

    view_map

    open_place("Farmhouse") do
      expect(page).to have_content("A great farmhouse")
      expect(page).to have_content("Stage: Complete")
      expect(page).to have_content("Contributors: Rose, Blake")
      expect(page).to have_link("http://example.com")
      expect(page).to have_selector("img")
    end
  end

  def open_form(type)
    visit "/"
    click_link "Add a place"
    click_link type
  end

  def fill_in_address(address)
    fill_in "Address", with: address

    page.execute_script "$('#place_address').trigger('geocode')"
    expect(page).to have_selector("#place_lat", visible: false) { |field|
      field.value.present?
    }
  end

  def submit_form
    click_button "Submit"
    expect(page).to have_content("Thanks")
  end

  def accept_submission
    place = Place.order("created_at desc").first

    visit admin_root_path
    click_button "Accept"

    expect(place.reload).to be_accepted
  end

  def view_map
    visit "/"
  end

  def open_place(name)
    find("[title='#{name}']").click

    within(".leaflet-popup") do
      yield
    end
  end
end
