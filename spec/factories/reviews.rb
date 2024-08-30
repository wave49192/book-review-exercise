FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.sentence(word_count: 20) }
    star { rand(1..5) }
    association :book
  end
end
