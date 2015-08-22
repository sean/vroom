require "rails_helper"

RSpec.feature "Users can create new people" do
  scenario "with valid attributes" do
    visit "/people"
    click_link "New Person"
    fill_in "Name", with: "John Smith"
    fill_in "Title", with: "Software Engineer"
    click_button "Create Person"
    expect(page).to have_content "Person has been created."
    person = Person.find_by(name: "John Smith")
    expect(page.current_url).to eq person_url(person)
    title = "John Smith - People - Lighthouse"
    expect(page).to have_title title
  end
end