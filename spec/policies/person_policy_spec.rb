require 'rails_helper'

describe PersonPolicy do

  subject { described_class }

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
