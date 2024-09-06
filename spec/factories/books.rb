# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  name        :string           not null
#  release     :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    release { Faker::Date.between(from: '2000-01-01', to: '2024-12-31') }
  end
end
