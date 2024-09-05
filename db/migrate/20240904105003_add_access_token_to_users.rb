class AddAccessTokenToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :access_token, :string
  end
end
