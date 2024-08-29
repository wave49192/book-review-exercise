class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: %i[edit update destroy ]

  def create
    @review = @book.reviews.create(review_params)
    if @review.save
      redirect_to @book
    else
      redirect_to book_path(@book, error: @review.errors.full_messages)
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @book
    else
      redirect_to edit_book_review_path(@book, error: @review.errors.full_messages)
    end
  end

  def destroy
    if @review.destroy
      redirect_to @book, notice: "Delete successfully"
    else
      redirect_to book_path(@book), alert: @review.errors.full_messages.to_sentence
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :star)
  end
end
