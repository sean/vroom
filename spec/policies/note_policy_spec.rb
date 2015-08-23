require 'rails_helper'

describe NotePolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions :show? do
    let(:user) { FactoryGirl.create :user }
    let(:person) { FactoryGirl.create :person, owner: user }
    let(:note) { FactoryGirl.create :note, person: person }

    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, note)
    end

    it "allows the owner to access" do
      expect(subject).to permit(user, note)
    end

    it "doesn't allow others to access" do
      other_user = FactoryGirl.create :user
      expect(subject).not_to permit(other_user, note)
    end
  end

end
