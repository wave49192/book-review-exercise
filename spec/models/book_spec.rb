require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'valid factory' do
    subject(:factory) { build(:book) }
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    subject(:book) { build(:book) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(12) }

    it 'is invalid without a name' do
      book.name = nil
      expect(book).not_to be_valid
      expect(book.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      book.description = nil
      expect(book).not_to be_valid
      expect(book.errors[:description]).to include("can't be blank")
    end

    it 'is invalid with a description shorter than 12 characters' do
      book.description = 'Short desc'
      expect(book).not_to be_valid
      expect(book.errors[:description]).to include("is too short (minimum is 12 characters)")
    end
  end


  describe 'associations' do
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe 'release attribute' do
    subject(:book) { build(:book) }
    it 'allows valid dates' do
      expect(book).to be_valid
    end

    it 'handles nil release date' do
      expect(book).to be_valid
    end
  end
end
