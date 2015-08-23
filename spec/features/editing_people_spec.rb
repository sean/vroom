require "rails_helper"

RSpec.feature "Users can edit existing projects" do
  let(:owner) { FactoryGirl.create(:user) }
  # appears to be a race condition which prevents this from working
  # let(:person) { FactoryGirl.create(:person, name: "John Smith", owner: owner) }

  before do
    login_as(owner)
    FactoryGirl.create(:person, name: "John Smith", owner: owner)
    visit "/people"
    click_link "John Smith"
    click_link "Edit Person"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Joe Smith"
    click_button "Update Person"
    expect(page).to have_content "Person has been updated."
    expect(page).to have_content "Joe Smith"
  end

  scenario "when providing invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Person"
    expect(page).to have_content "Person has not been updated."
  end
end