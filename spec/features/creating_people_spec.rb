require "rails_helper"

RSpec.feature "Users can create new people" do
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    login_as(user)
    visit "/people"
    click_link "New Person"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "John Smith"
    fill_in "Title", with: "Software Engineer"
    click_button "Create Person"
    expect(page).to have_content "Person has been created."
    person = Person.find_by(name: "John Smith")
    expect(page.current_url).to eq person_url(person)
    title = "John Smith - People - Lighthouse"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    click_button "Create Person"
    expect(page).to have_content "Person has not been created."
    expect(page).to have_content "Name can't be blank"
  end
end