require "rails_helper"

RSpec.feature "Users can delete notes" do
  let(:owner)  { FactoryGirl.create(:user) }
  let(:person) { FactoryGirl.create(:person, owner: owner) }
  let(:note)  { FactoryGirl.create(:note, person: person) }

  before do
    login_as(owner)
    visit person_note_path(person, note)
  end

  scenario "successfully" do
    click_link "Delete Note"
    expect(page).to have_content "Note has been deleted."
    expect(page.current_url).to eq person_url(person)
  end
end