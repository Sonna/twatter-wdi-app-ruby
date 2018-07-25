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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "block_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "block_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "twat_id"
  end

  create_table "followers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "follower_id"
  end

  create_table "likes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "twat_id"
  end

  create_table "retwats", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "twat_id"
  end

  create_table "twats", id: :serial, force: :cascade do |t|
    t.text "message"
    t.integer "user_id"
    t.integer "comments_count", default: 0
    t.integer "likes_count", default: 0
    t.integer "retwats_count", default: 0
    t.date "created_at"
    t.date "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 300, null: false
    t.string "name", limit: 300, null: false
    t.string "email", limit: 300, null: false
    t.string "password_digest", limit: 400, null: false
  end

end
