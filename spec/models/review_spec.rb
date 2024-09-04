require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'valid factory' do
    subject(:factory) { build(:review) }
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    subject(:review) { build(:review) }

    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_presence_of(:star) }
    it { is_expected.to validate_numericality_of(:star).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_numericality_of(:star).is_less_than_or_equal_to(5) }
    it { should belong_to(:book) }

    it 'is invalid without a comment' do
      review.comment = nil
      expect(review).not_to be_valid
      expect(review.errors[:comment]).to include("can't be blank")
    end

    it 'is valid with a comment of exactly 20 characters' do
      review.comment = 'a' * 20
      expect(review).to be_valid
    end

    it 'is invalid with a comment shorter than 20 characters' do
      review.comment = 'Short comment'
      expect(review).not_to be_valid
      expect(review.errors[:comment]).to include("is too short (minimum is 20 characters)")
    end

    it 'is invalid without a star' do
      review.star = nil
      expect(review).not_to be_valid
      expect(review.errors[:star]).to match_array([ "can't be blank", "is not a number" ])
    end

    it 'is invalid with a star outside the allowed range' do
      review.star = 0
      expect(review).not_to be_valid
      expect(review.errors[:star]).to include("must be greater than or equal to 1")

      review.star = 6
      expect(review).not_to be_valid
      expect(review.errors[:star]).to include("must be less than or equal to 5")
    end

    it 'is invalid without a book' do
      review.book = nil
      expect(review).not_to be_valid
      expect(review.errors[:book]).to match_array([ "must exist" ])
    end
  end
end
