FactoryGirl.define do
  factory :rent do
    openned_at DateTime.now - 1.hour
    closed_at DateTime.now
    bike
    user
  end
end
