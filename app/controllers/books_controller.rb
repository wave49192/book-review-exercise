class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user!
  after_action :clear_cache, only: %i[create update destroy]

  def index
    page = params[:page].to_i.positive? ? params[:page] : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page] : 3
    cache_key = "books/page/#{page}/per_page/#{per_page}"

    @books = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      Book.order(:name).all.to_a
    end

    @books = Kaminari.paginate_array(@books).page(page).per(per_page)
  end


  def show
    cache_key = "book/#{@book.id}/reviews"
    @reviews = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      @book.reviews.to_a
    end
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

  def clear_cache
    Rails.cache.delete_matched("books/page/*/per_page/*")
    Rails.cache.delete("book/#{@book.id}/reviews") if @book.present?
  end

  def set_book
    @book ||= Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :description, :release)
  end
end
