require "rails_helper"

RSpec.feature "Users can view notes" do
  let(:owner)  { FactoryGirl.create(:user) }

  before do
    jsmith = FactoryGirl.create(:person, name: "John Smith", owner: owner)
    FactoryGirl.create(:note, person: jsmith,
                       details: "Wants to be a team lead.")
    jdoe = FactoryGirl.create(:person, name: "John Doe", owner: owner)
    FactoryGirl.create(:note, person: jdoe,
                       details: "Wants to learn Scala.")
    login_as(owner)
    visit "/people" 
  end

  scenario "for a given person" do
    click_link "John Smith"
    expect(page).to have_content "Wants to be a team lead."
    click_link "Wants to be a team lead."
    within("#note h2") do
      expect(page).to have_content "Wants to be a team lead."
    end
    expect(page).to have_content "2015-01-01 17:00:00 UTC"
  end
end