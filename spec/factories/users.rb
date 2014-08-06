FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "name_#{n}"}
    sequence(:surname) {|n| "surname_#{n}"}
  end
end
