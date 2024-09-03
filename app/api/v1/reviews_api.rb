module V1
  class ReviewsApi < Grape::API
    format :json

    resource :books do
      route_param :book_id do
        resource :reviews do
          desc "Returns a list of reviews for a specific book"
          get do
            book = Book.find(params[:book_id])
            reviews = book.reviews

            if reviews.empty?
              error!({ message: "No reviews found for this book" }, 404)
            else
              present reviews, with: Entities::ReviewEntity
            end
          end

          desc "Create a review for a book"
          params do
            requires :comment, type: String, desc: "Comment content"
            requires :star, type: Integer, desc: "Star (1-5)"
          end
          post do
            review = Review.new({
              book_id: params[:book_id],
              comment: params[:comment],
              star: params[:star]
            })
            if review.save
              present review, with: Entities::ReviewEntity
            else
              error!({ error: review.errors.full_messages }, 422)
            end
          end

          desc "Update a review for a book"
          params do
            requires :review_id, type: Integer, desc: "Review ID"
            optional :comment, type: String, desc: "Comment content"
            optional :star, type: Integer, desc: "Star rating (1-5)", values: (1..5)
          end
          put ":review_id" do
            book = Book.find_by(id: params[:book_id])
            if book.nil?
              error!({ message: "Book not found" }, 404)
            else
              review = book.reviews.find_by(id: params[:review_id])
              if review.nil?
                error!({ message: "Review not found" }, 404)
              else
                if review.update({
                  comment: params[:comment],
                  star: params[:star]
                })
                  present review, with: Entities::ReviewEntity
                else
                  error!({ error: review.errors.full_messages }, 422)
                end
              end
            end
          end

          desc "Delete a review"
          params do
            requires :review_id, type: Integer, desc: "Review ID"
          end
          delete ":review_id" do
            review = Review.find_by(id: params[:review_id])
            if review.destroy
              { message: "Review deleted successfully" }
            else
              error!({ error: "Failed to delete the review" }, 422)
            end
          end
        end
      end
    end
  end
end
