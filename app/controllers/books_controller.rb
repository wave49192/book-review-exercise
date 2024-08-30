class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user!
  def index
    @books = Book.all
  end

  def show
    @reviews = @book.reviews
    @review = Review.new
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
   @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      redirect_to new_book_path(error: @book.errors.full_messages)
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      redirect_to edit_book_path(error: @book.errors.full_messages)
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end

  private

  def set_book
    @book ||= Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :description, :release)
  end
end
