FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.sentence }
    star { rand(1..5) }
    association :book
  end
end
