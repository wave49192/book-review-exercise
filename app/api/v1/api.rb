module V1
  class API < Grape::API
    format :json
    prefix :v1

    mount V1::BooksApi
    mount V1::ReviewsApi
    mount V1::AuthApi

    helpers do
      def authenticate_token!
        token = cookies[:access_token]
        @current_user = User.find_by(access_token: token)

        error!('Unauthorized please sign in', 401) unless @current_user
      end
    end
  end
end
