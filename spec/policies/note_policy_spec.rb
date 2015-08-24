require 'rails_helper'
require 'support/pundit_matcher'

RSpec.describe NotePolicy do
  context "permissions" do
    subject { NotePolicy.new(user, note) }

    let(:user) { FactoryGirl.create(:user) }
    let(:owner) { FactoryGirl.create(:user) }
    let(:person) { FactoryGirl.create(:person, owner: owner) }
    let(:note) { FactoryGirl.create(:note, person: person) }

    context "for anonymous users" do
      let(:user) { nil }
      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context "for owners of the person" do
      let(:user) { owner }
      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :create }
      it { should permit_action :destroy }
    end

    context "for other users" do
      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :create }
      it { should_not permit_action :destroy }
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }
      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :create }
      it { should permit_action :destroy }
    end
  end 
end