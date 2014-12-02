# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141202230634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: true do |t|
    t.integer "user_id"
    t.integer "time_slot_id"
  end

  create_table "friend_requests", force: true do |t|
    t.integer  "requester_id"
    t.integer  "recipient_id"
    t.boolean  "accepted",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "games", force: true do |t|
    t.string  "title"
    t.integer "platform_id"
  end

  create_table "match_attributes", force: true do |t|
    t.integer "user_id"
    t.integer "match_trait_id"
  end

  create_table "match_traits", force: true do |t|
    t.string  "description"
    t.boolean "user_created", default: false
  end

  create_table "matches", force: true do |t|
    t.integer  "user_id"
    t.integer  "matched_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "actioned",        default: false
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "deleted",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outside_activities", force: true do |t|
    t.string  "description"
    t.boolean "user_created", default: false
  end

  create_table "platforms", force: true do |t|
    t.string "name"
  end

  create_table "player_attributes", force: true do |t|
    t.integer "user_id"
    t.integer "trait_id"
  end

  create_table "preferred_activities", force: true do |t|
    t.integer "user_id"
    t.integer "outside_activity_id"
  end

  create_table "signup_requests", force: true do |t|
    t.string "hex_id"
    t.string "email"
  end

  create_table "time_slots", force: true do |t|
    t.integer "weekday"
    t.integer "hour"
  end

  create_table "traits", force: true do |t|
    t.string  "description"
    t.boolean "user_created", default: false
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.integer  "personal_rank",          default: 50
    t.integer  "mic_style",              default: 50
    t.integer  "play_style",             default: 50
    t.text     "desc_words"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.date     "date_of_birth"
    t.string   "postal_code"
    t.integer  "game_id"
    t.string   "occupation"
    t.string   "gamertag"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["game_id"], name: "index_users_on_game_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
