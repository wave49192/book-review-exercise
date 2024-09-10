class CreateBookRanks < ActiveRecord::Migration[7.2]
  def change
    create_table :book_ranks do |t|
      t.references :book, null: false, foreign_key: true
      t.references :rank, null: false, foreign_key: true
      t.integer :view, default: 0
      t.integer :order_id

      t.timestamps
    end

    add_index :book_ranks, [ :book_id, :rank_id ], unique: true
  end
end
