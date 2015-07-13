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

ActiveRecord::Schema.define(version: 20130303214320) do

  create_table "games", force: true do |t|
    t.string   "game_session"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "player_cards",   limit: 150
    t.string   "computer_cards", limit: 150
    t.string   "deck_cards",     limit: 150
    t.string   "attacker_cards", limit: 50
    t.string   "defender_cards", limit: 50
    t.integer  "trump",          limit: 2
    t.integer  "attacker",       limit: 2
    t.integer  "defender_state", limit: 2
    t.boolean  "game_finished"
    t.string   "message",        limit: 50
  end

  add_index "games", ["game_session"], name: "index_games_on_game_session", using: :btree

end
