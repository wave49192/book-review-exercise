FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    release { Faker::Date.between(from: '2000-01-01', to: '2024-12-31') }
  end
end
