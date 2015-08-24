require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  let(:owner) { FactoryGirl.create(:user) }

  it "handles a missing person correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(people_path)
    message = "The person you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it "handles permission errors by redirecting to a safe place" do
    allow(controller).to receive(:current_user) { FactoryGirl.create(:user) }
    person = FactoryGirl.create(:person, owner: owner)
    get :show, id: person
    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
