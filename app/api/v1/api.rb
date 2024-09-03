module V1
  class API < Grape::API
    format :json
    prefix :v1
    mount V1::BooksApi
    mount V1::ReviewsApi
  end
end
