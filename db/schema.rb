# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_06_093802) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_ranks", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "rank_id", null: false
    t.integer "view", default: 0
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "rank_id"], name: "index_book_ranks_on_book_id_and_rank_id", unique: true
    t.index ["book_id"], name: "index_book_ranks_on_book_id"
    t.index ["rank_id"], name: "index_book_ranks_on_rank_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.date "release"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.datetime "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_ranks_on_date", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comment", null: false
    t.integer "star", default: 0, null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "book_ranks", "books"
  add_foreign_key "book_ranks", "ranks"
  add_foreign_key "reviews", "books"
end
