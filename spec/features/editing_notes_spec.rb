require "rails_helper"

RSpec.feature "Users can edit existing notes" do
  let(:owner)  { FactoryGirl.create(:user) }
  let(:person) { FactoryGirl.create(:person, owner: owner) }
  let(:note)  { FactoryGirl.create(:note, person: person) }

  before do
    login_as(owner)
    visit person_note_path(person, note)
    click_link "Edit Note"
  end

  scenario "with valid attributes" do
    fill_in "Details", with: "Wants to learn Python."
    click_button "Update Note"
    expect(page).to have_content "Note has been updated."
    within("#note h2") do
      expect(page).to have_content "Wants to learn Python."
      expect(page).not_to have_content note.details
    end 
  end

  scenario "with invalid attributes" do
    fill_in "Details", with: ""
    click_button "Update Note"
    expect(page).to have_content "Note has not been updated."
  end
end