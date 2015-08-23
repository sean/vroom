require "rails_helper"
        
RSpec.feature "Users can delete people" do
  let(:owner)  { FactoryGirl.create(:user) }

  scenario "successfully" do
    FactoryGirl.create(:person, name: "John Smith", owner: owner)
    visit "/people"
    click_link "John Smith"
    click_link "Delete Person"
    expect(page).to have_content "Person has been deleted."
    expect(page.current_url).to eq people_url
    expect(page).to have_no_content "John Smith"
  end
end