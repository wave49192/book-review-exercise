class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.date :release

      t.timestamps
    end
  end
end
