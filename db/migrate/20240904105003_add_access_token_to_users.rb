class AddAccessTokenToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :access_token, :string
    remove_column :users, :authentication_token, :string
  end
end
