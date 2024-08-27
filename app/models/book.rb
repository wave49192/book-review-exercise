class Book < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length:  { minimum: 12 }
end
