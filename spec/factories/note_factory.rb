FactoryGirl.define do
  factory :note do
    details "Wants to be a team lead."
    created_at Time.new(2015,01,01,12,00,00, "-05:00")
  end
end