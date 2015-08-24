require 'rails_helper'
require 'support/pundit_matcher'

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

  context "permissions" do
    subject { PersonPolicy.new(user, person) }
  
    let(:user) { FactoryGirl.create(:user) }
    let(:owner) { FactoryGirl.create(:user) }
    let(:person) { FactoryGirl.create(:person, owner: owner) }
  
    context "for anonymous users" do
      let(:user) { nil }
      it { should_not permit_action :create }
      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end

    context "for owners of the person" do
      let(:user) { owner }
      it { should permit_action :create }
      it { should permit_action :show }
      it { should permit_action :update }
    end
  
    context "for other users" do
      let(:user) { FactoryGirl.create(:user) }
      it { should_not permit_action :create }
      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end
  
    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }
      it { should permit_action :create }
      it { should permit_action :show }
      it { should permit_action :update }
    end
  end            

end
