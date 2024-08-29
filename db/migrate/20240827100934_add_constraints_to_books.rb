class AddConstraintsToBooks < ActiveRecord::Migration[7.2]
  def change
    change_column_null :books, :name, false
    change_column_null :books, :description, false
  end
end
