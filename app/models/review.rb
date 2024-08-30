# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  comment    :string           not null
#  star       :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#
# Indexes
#
#  index_reviews_on_book_id  (book_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#
class Review < ApplicationRecord
  validates :comment, presence: true, length: { minimum: 20 }
  validates :star, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  belongs_to :book
end
