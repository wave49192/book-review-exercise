module V1
  class AuthApi < Grape::API
    format :json

    helpers do
      def authenticate_user!(email, password)
        user = User.find_by(email: email)
        if user && user.valid_password?(password)
          user.regenerate_access_token
          user.save
          user
        else
          error!("Invalid Email or Password", 401)
        end
      end

      def create_user!(email, password, password_confirmation)
        user = User.new(email: email, password: password, password_confirmation: password_confirmation)
        if user.save
          user.regenerate_access_token
          user.save
          user
        else
          error!(user.errors.full_messages, 422)
        end
      end
    end

    resource :auth do
      desc "Sign in a user"
      params do
        requires :email, type: String, desc: "User's email"
        requires :password, type: String, desc: "User's password"
      end
      post "sign_in" do
        user = authenticate_user!(params[:email], params[:password])
        cookies[:access_token] = {
          value: user.access_token,
          httponly: true,
          same_site: :lax
        }
        present message: "Logged in successfully."
      end

      desc "Sign out a user"
      delete "sign_out" do
        token = cookies[:access_token]
        if token.nil?
          error!("Unauthorized, no access token provided", 401)
        end
        current_user = User.find_by(access_token: token)
        if current_user
          current_user.update(access_token: nil)
          cookies.delete(:access_token)
          { message: "Logged out successfully" }
        else
          error!("Unauthorized, invalid token", 401)
        end
      end

      desc "Register a new user"
      params do
        requires :email, type: String, desc: "User's email"
        requires :password, type: String, desc: "User's password"
        requires :password_confirmation, type: String, desc: "User's password confirmation"
      end

      post "register" do
        user = create_user!(params[:email], params[:password], params[:password_confirmation])
        cookies[:access_token] = {
          value: user.access_token,
          httponly: true,
          same_site: :lax
        }
        present message: "User registered successfully."
      end
    end
  end
end
