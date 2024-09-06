module V1
  class ReviewsApi < Grape::API
    format :json

    before do
      authenticate_token!
    end

    resource :books do
      route_param :book_id do
        helpers do
          def book
            @book ||= Book.find(params[:book_id])
          rescue ActiveRecord::RecordNotFound
            error!({ error: "Book not found" }, 404)
          end

          def review
            @review ||= book.reviews.find(params[:review_id])
          rescue ActiveRecord::RecordNotFound
            error!({ error: "Review not found" }, 404)
          end
        end

        resource :reviews do
          desc "Returns a list of reviews for a specific book"
          get do
            reviews = book.reviews
            if reviews.empty?
              error!({ error: "Reviews not found for this book" }, 404)
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
            review
            if review.update({
              comment: params[:comment],
              star: params[:star]
            })
              present review, with: Entities::ReviewEntity
            else
              error!({ error: review.errors.full_messages }, 422)
            end
          end

          desc "Delete a review"
          params do
            requires :review_id, type: Integer, desc: "Review ID"
          end
          delete ":review_id" do
            review
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
