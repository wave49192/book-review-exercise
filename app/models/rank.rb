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
class Rank < ApplicationRecord
  has_many :book_ranks
end
