class Review < ApplicationRecord
  validates :comment, presence: true, length: { minimum: 20 }
  validates :star, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  belongs_to :book
end
