class CreateRanks < ActiveRecord::Migration[7.2]
  def change
    create_table :ranks do |t|
      t.datetime :date, null:false

      t.timestamps
    end

    add_index :ranks, :date, unique: true
  end
end
