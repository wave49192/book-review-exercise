# == Schema Information
#
# Table name: ranks
#
#  id         :bigint           not null, primary key
#  date       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ranks_on_date  (date) UNIQUE
#
FactoryBot.define do
  factory :rank do
    date { "2024-09-06 16:32:12" }
  end
end
