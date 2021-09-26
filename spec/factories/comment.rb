FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentences }
    post
    user
  end
end
