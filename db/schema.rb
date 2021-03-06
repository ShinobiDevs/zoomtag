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

ActiveRecord::Schema.define(version: 20130730103152) do

  create_table "challanges", force: true do |t|
    t.string   "image_url"
    t.string   "easy_tag"
    t.string   "medium_tag"
    t.string   "hard_tag"
    t.integer  "player_id"
    t.string   "hint"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.integer  "guessed_by_id"
  end

  create_table "games", force: true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "started_by_player_id"
    t.integer  "current_turn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "waiting_to_challange", default: true
  end

  add_index "games", ["player1_id"], name: "index_games_on_player1_id", using: :btree
  add_index "games", ["player2_id"], name: "index_games_on_player2_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_uuid"
    t.string   "facebook_access_token"
    t.string   "name"
    t.string   "profile_picture"
  end

  add_index "players", ["authentication_token"], name: "index_players_on_authentication_token", unique: true, using: :btree
  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree
  add_index "players", ["facebook_access_token"], name: "index_players_on_facebook_access_token", using: :btree
  add_index "players", ["facebook_uuid"], name: "index_players_on_facebook_uuid", using: :btree
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree

end
