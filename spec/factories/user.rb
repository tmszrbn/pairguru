FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    after(:build) { |user| user.skip_confirmation! }
  end
end
