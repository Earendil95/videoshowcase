# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_23_013656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.text "title"
    t.text "plot"
    t.integer "number"
    t.text "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "episodes", force: :cascade do |t|
    t.text "title"
    t.text "plot"
    t.integer "number"
    t.integer "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "purchase_options", force: :cascade do |t|
    t.text "quality"
    t.integer "price"
    t.bigint "content_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_purchase_options_on_content_id"
  end

  create_table "purchasings", force: :cascade do |t|
    t.bigint "purchase_option_id", null: false
    t.bigint "content_id", null: false
    t.bigint "user_id", null: false
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_purchasings_on_content_id"
    t.index ["purchase_option_id"], name: "index_purchasings_on_purchase_option_id"
    t.index ["user_id"], name: "index_purchasings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "episodes", "contents", column: "season_id"
  add_foreign_key "purchase_options", "contents"
  add_foreign_key "purchasings", "contents"
  add_foreign_key "purchasings", "purchase_options"
  add_foreign_key "purchasings", "users"
end
