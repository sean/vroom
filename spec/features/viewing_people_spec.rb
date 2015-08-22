require "rails_helper"
        
RSpec.feature "Users can view people" do
  scenario "with the person's details" do
    person = FactoryGirl.create(:person, 
                                name: "John Smith",
                                title: "Software Engineer")
    visit "/people"
    click_link "John Smith"
    expect(page.current_url).to eq person_url(person)
  end 
end