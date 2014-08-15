# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bike_location do
    bike nil
    lat "9.99"
    lng "9.99"
    date "2014-08-15 13:20:53"
  end
end
