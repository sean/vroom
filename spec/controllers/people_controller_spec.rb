require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  it "handles a missing person correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(people_path)
    message = "The person you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
end
