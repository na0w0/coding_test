FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password = Faker::Internet.password
    password { password }
    password_confirmation { password }
  end
end
