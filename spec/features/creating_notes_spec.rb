require "rails_helper"

RSpec.feature "Users can create new notes" do
  let(:owner)  { FactoryGirl.create(:user) }
  let(:person) { FactoryGirl.create(:person, name: "John Smith", owner: owner) }

  before do
    login_as(owner)
    visit person_path(person)
    click_link "New Note"
  end

  scenario "with valid attributes" do
    fill_in "Details", with: "Wants to be a team lead."
    click_button "Create Note"
    expect(page).to have_content "Note has been created."
  end

  scenario "when providing invalid attributes" do
    click_button "Create Note"
    expect(page).to have_content "Note has not been created."
    expect(page).to have_content "Details can't be blank"
  end 
end