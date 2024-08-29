class AddConstraintsToReviews < ActiveRecord::Migration[7.2]
  def change
    change_column_null :reviews, :comment, false
    change_column_null :reviews, :star, false

    change_column_default :reviews, :star, 0
  end
end
