# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :station do
    latitude 54.966667
    longitude 73.383333
    sequence(:name) {|n| "station_#{n}"} 
  end
end
