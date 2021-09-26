FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    content { Faker::Lorem.sentences }
    user
  end
end
