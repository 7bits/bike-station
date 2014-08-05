FactoryGirl.define do
  factory :bike do
    station
    sequence(:uuid) { |n| "This-is-your-UUID-#{n}" }
    registration_id 'My-Register-Id'
  end
end
