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
class Book < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length:  { minimum: 12 }

  has_many :reviews, dependent: :destroy

  def books_key
    "books/index"
  end
  def book_reviews_key
    "book/#{id}/reviews"
  end
end
