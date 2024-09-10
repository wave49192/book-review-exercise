class Book < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 12 }

  has_many :reviews, dependent: :destroy

  def self.books_key
    'books/index'
  end

  def book_reviews_key
    "book/#{id}/reviews"
  end
end
