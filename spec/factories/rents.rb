FactoryGirl.define do
  factory :rent do
    openned_at DateTime.now - 1.hour
    closed_at DateTime.now
    bike
    user
    association :starting_station, factory: :station
    association :terminal_station, factory: :station
  end
end
