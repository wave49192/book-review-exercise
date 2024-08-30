require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let!(:book) { create(:book) }
  let!(:review) { create(:review, book: book) }

  describe "GET /books/:book_id" do
    let!(:reviews) { create_list(:review, 5, book: book) }
    before { get book_path(book) }

    it "returns a successful response" do
      expect(response).to be_successful
      expect(response.body).to include("Reviews")
    end

    it "renders all comments" do
      reviews.each do |review|
        expect(response.body).to include(review.comment)
      end
    end
  end

  describe "POST /books/:book_id/reviews" do
    context "with valid parameters" do
      let(:valid_attributes) { { review: { comment: "Great book! Really enjoyed it.", star: 5 } } }

      it "creates a new review" do
        expect {
          post book_reviews_path(book), params: valid_attributes
        }.to change(Review, :count).by(1)

        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to be_nil
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { review: { comment: "Short", star: 0 } } }

      it "does not create a new review" do
        expect {
          post book_reviews_path(book), params: invalid_attributes
        }.not_to change(Review, :count)

        expect(response).to redirect_to(book_path(book, error: [ "Comment is too short (minimum is 20 characters)", "Star must be greater than or equal to 1" ]))
      end
    end
  end

  describe "GET /books/:book_id/reviews/:id/edit" do
    before { get edit_book_review_path(book, review) }

    it "returns a successful response" do
      expect(response).to be_successful
      expect(response.body).to include("Edit Review")
    end
  end

  describe "PATCH /books/:book_id/reviews/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { review: { comment: "Updated comment comment comment", star: 4 } } }

      it "updates the requested review" do
        patch book_review_path(book, review), params: new_attributes
        review.reload

        expect(review.comment).to eq("Updated comment comment comment")
        expect(review.star).to eq(4)
        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to be_nil
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { review: { comment: "Short", star: 6 } } }

      it "does not update the review" do
        patch book_review_path(book, review), params: invalid_attributes
        review.reload

        expect(review.comment).not_to eq("Short")
        expect(review.star).not_to eq(6)
        expect(response).to redirect_to(edit_book_review_path(book, review, error: [ "Comment is too short (minimum is 20 characters)", "Star must be less than or equal to 5" ]))
      end
    end
  end

  describe "DELETE /books/:book_id/reviews/:id" do
    it "destroys the requested review" do
      expect {
        delete book_review_path(book, review)
      }.to change(Review, :count).by(-1)

      expect(response).to redirect_to(book_path(book))
      expect(flash[:notice]).to eq("Delete successfully")
    end
  end
end
