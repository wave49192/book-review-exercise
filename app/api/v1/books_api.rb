module V1
  class BooksApi < Grape::API
    format :json

    resource :books do
      desc "Return a list of books"
      params do
        optional :page, type: Integer, desc: "Page number"
        optional :per_page, type: Integer, desc: "Number of books per page"
      end
      get do
        books = Book.order(:name).page(params[:page]).per(params[:per_page] || 3)
        present books, with: Entities::BookEntity
      end

      desc "Return a specific book"
      params do
        requires :id, type: Integer, desc: "Book ID"
      end
      get ":id" do
        book = Book.find(params[:id])
        present book, with: Entities::BookEntity
      end

      desc "Create a book"
      params do
        requires :name, type: String, desc: "Name of the book"
        requires :description, type: String, desc: "Description of the book"
        optional :release, type: Date, desc: "Release date of the book"
      end
      post do
        book = Book.new({
          name: params[:name],
          description: params[:description],
          release: params[:release]
        })
        if book.save
          present book, with: Entities::BookEntity
        else
          error!({ error: book.errors.full_messages }, 422)
        end
      end

      desc "Update a book"
      params do
        requires :id, type: Integer, desc: "Book ID"
        optional :name, type: String, desc: "Name of the book"
        optional :description, type: String, desc: "Description of the book"
        optional :release, type: Date, desc: "Release date of the book"
      end
      put ":id" do
        book = Book.find(params[:id])
        if book.update({
          name: params[:name],
          description: params[:description],
          release: params[:release]
        })
          present book, with: Entities::BookEntity
        else
          error!({ error: book.errors.full_messages }, 422)
        end
      end

      desc "Delete a book"
      params do
        requires :id, type: Integer, desc: "Book ID"
      end
      delete ":id" do
        book = Book.find(params[:id])
        if book.destroy
          { message: "Book deleted successfully" }
        else
          error!({ error: "Failed to delete the book" }, 422)
        end
      end
    end
  end
end
