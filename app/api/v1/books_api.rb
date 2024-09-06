module V1
  class BooksApi < Grape::API
    format :json

    resource :books do
      helpers do
        def book
          @book ||= Book.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!({ error: "Book not found" }, 404)
        end

        def create_book
          @book = Book.new({
            name: params[:name],
            description: params[:description],
            release: params[:release]
          })
        end
      end

      desc "Return a list of books"
      params do
        optional :page, type: Integer, desc: "Page number", default: 1
        optional :per_page, type: Integer, desc: "Number of books per page", default: 3
      end
      get do
        books = Book.order(:name).page(params[:page]).per(params[:per_page])
        present books, with: Entities::BookEntity
      end

      route_param :id do
        desc "Return a specific book"
        get do
          present book, with: Entities::BookEntity
        end

        desc "Update a book"
        params do
          optional :name, type: String, desc: "Name of the book"
          optional :description, type: String, desc: "Description of the book"
          optional :release, type: Date, desc: "Release date of the book"
        end
        put do
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
        delete do
          if book.destroy
            { message: "Book deleted successfully" }
          else
            error!({ error: "Failed to delete the book" }, 422)
          end
        end
      end

      desc "Create a book"
      params do
        requires :name, type: String, desc: "Name of the book"
        requires :description, type: String, desc: "Description of the book"
        optional :release, type: Date, desc: "Release date of the book"
      end
      post do
        book = create_book
        if book.save
          present book, with: Entities::BookEntity
        else
          error!({ error: book.errors.full_messages }, 422)
        end
      end
    end
  end
end
