FactoryBot.define do
  factory :comment do
    association :movie
    association :user
    body { Faker::Lorem.sentence }
  end
end
