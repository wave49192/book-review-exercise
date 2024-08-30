require 'rails_helper'

RSpec.describe "Books", type: :request do
  let!(:books) { create_list(:book, 3) }  # Create 3 books for index test
  describe "GET /index" do
    before { get books_path }

    it "returns a successful response" do
      expect(response).to be_successful
      expect(response.body).to include("Books")
    end

    it "returns a successful response and renders all book names" do
      expect(response).to be_successful

      books.each do |book|
        expect(response.body).to include(book.name)
      end
    end
  end

  describe "GET /show" do
  let!(:book) { books.first }

    it "returns a successful response" do
      get book_path(book)
      expect(response).to be_successful
      expect(response.body).to include(book.name)
    end
  end

  describe "GET /new" do
    it "returns a successful response" do
      get new_book_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
  let!(:book) { books.first }

    it "returns a successful response" do
      get edit_book_path(book)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "when updates with valid parameters" do
      it "creates a new Book and redirects to its show page" do
        book_params = attributes_for(:book)
        post books_path, params: { book: book_params }
        expect(response).to redirect_to(book_path(Book.last))
        expect(Book.count).to eq(books.size + 1)
      end
    end

    context "when updates with invalid parameters" do
      it "does not create a new Book and redirects to the new page" do
        invalid_params = attributes_for(:book, name: nil)
        post books_path, params: { book: invalid_params }
        expect(response).to redirect_to(new_book_path(error: [ "Name can't be blank" ]))
        expect(Book.count).to eq(books.size)
      end
    end
  end

  describe "PATCH /update" do
     let(:book) { books.first }
    context "with valid parameters" do
      it "updates the requested book and redirects to its show page" do
        new_name = "Updated Book Name"
        patch book_path(book), params: { book: { name: new_name } }
        book.reload
        expect(book.name).to eq(new_name)
        expect(response).to redirect_to(book_path(book))
      end
    end

    context "with invalid parameters" do
      it "does not update the book and redirects to the edit page" do
        patch book_path(book), params: { book: { name: nil } }
        book.reload
        expect(book.name).not_to be_nil
        expect(response).to redirect_to(edit_book_path(book, error: [ "Name can't be blank" ]))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested book and redirects to the root path" do
      book_to_delete = create(:book)
      expect {
        delete book_path(book_to_delete)
      }.to change(Book, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end
end
