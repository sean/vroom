require 'rails_helper'

describe PersonPolicy do

  subject { described_class }

  context "policy_scope" do
    subject { Pundit.policy_scope(user, Person) }
    let(:user) { FactoryGirl.create :user }
    let!(:person) { FactoryGirl.create :person, owner: user }
  
    it "is empty for anonymous users" do
      expect(Pundit.policy_scope(nil, Person)).to be_empty
    end
  
    it "returns all projects for admins" do
      user.admin = true
      expect(subject).to include(person)
    end 
  end

  permissions :show? do
    let(:user) { FactoryGirl.create :user }
    let(:person) { FactoryGirl.create :person, owner: user }

    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, person)
    end

    it "allows the owner to access" do
      expect(subject).to permit(user, person)
    end

    it "doesn't allow others to access" do
      other_user = FactoryGirl.create :user
      expect(subject).not_to permit(other_user, person)
    end
  end

end
