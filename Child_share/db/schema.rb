# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_21_093607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_offers", force: :cascade do |t|
    t.string "status"
    t.text "note"
    t.bigint "user_id"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "child_count"
    t.index ["offer_id"], name: "index_book_offers_on_offer_id"
    t.index ["user_id"], name: "index_book_offers_on_user_id"
  end

  create_table "book_requests", force: :cascade do |t|
    t.string "status"
    t.text "note"
    t.bigint "user_id"
    t.bigint "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "child_count"
    t.index ["request_id"], name: "index_book_requests_on_request_id"
    t.index ["user_id"], name: "index_book_requests_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.boolean "is_active"
    t.string "status"
    t.bigint "offer_id"
    t.bigint "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_bookings_on_offer_id"
    t.index ["request_id"], name: "index_bookings_on_request_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "joins", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_joins_on_child_id"
    t.index ["user_id"], name: "index_joins_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.datetime "proposed_from"
    t.datetime "proposed_to"
    t.integer "max_child_number"
    t.text "note"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "proposed_from"
    t.datetime "proposed_to"
    t.integer "child_number"
    t.text "note"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body"
    t.integer "rating"
    t.bigint "user_id"
    t.bigint "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_reviews_on_child_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "actual_from"
    t.datetime "actual_to"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "advertisement_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.boolean "parent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "alias"
    t.string "location"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "book_offers", "offers"
  add_foreign_key "book_offers", "users"
  add_foreign_key "book_requests", "requests"
  add_foreign_key "book_requests", "users"
  add_foreign_key "bookings", "offers"
  add_foreign_key "bookings", "requests"
  add_foreign_key "joins", "children"
  add_foreign_key "joins", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "offers", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "reviews", "children"
  add_foreign_key "reviews", "users"
  add_foreign_key "transactions", "bookings", column: "advertisement_id"
  add_foreign_key "transactions", "users"
end
