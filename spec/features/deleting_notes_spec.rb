require "rails_helper"

RSpec.feature "Users can delete notes" do
  let(:person) { FactoryGirl.create(:person) }
  let(:note)  { FactoryGirl.create(:note, person: person) }

  before do
    visit person_note_path(person, note)
  end

  scenario "successfully" do
    click_link "Delete Note"
    expect(page).to have_content "Note has been deleted."
    expect(page.current_url).to eq person_url(person)
  end
end