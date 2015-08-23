require "rails_helper"
        
RSpec.feature "Users can view people" do
  let(:owner)  { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before do
    FactoryGirl.create(:person, 
                       name: "John Smith",
                       title: "Software Engineer",
                       owner: owner)
    FactoryGirl.create(:person,
                       name: "Joe Doe",
                       title: "SRE",
                       owner: other_user)    
  end

  scenario "with the person's details" do
    person = Person.find_by_name("John Smith")
    login_as(owner)
    visit "/people"
    click_link "John Smith"
    expect(page.current_url).to eq person_url(person)
  end 

  scenario "only the user's people are visible" do
    login_as(owner)
    visit "/people"
    expect(page).to have_content "John Smith"
    expect(page).not_to have_content "Joe Doe"
  end

  scenario "admin users can see everyone" do
    login_as(admin)
    visit "/people"
    expect(page).to have_content "John Smith"
    expect(page).to have_content "Joe Doe"
  end
end