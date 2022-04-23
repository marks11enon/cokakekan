FactoryBot.define do
  factory :user do
    name { "田中一郎" }
    email { Faker::Internet.email }
    password { "1234567" }
    password_confirmation { "1234567" }
  end
end
