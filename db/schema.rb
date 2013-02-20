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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130220173029) do

  create_table "cardholders", :force => true do |t|
    t.string   "ch_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cards", :force => true do |t|
    t.string   "rank"
    t.string   "suit"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "game_logs", :force => true do |t|
    t.integer  "game_id"
    t.integer  "cardholder_id"
    t.integer  "card_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "position"
    t.integer  "played_by"
    t.integer  "beated_with"
  end

  add_index "game_logs", ["game_id", "cardholder_id", "card_id"], :name => "index_game_logs_on_game_id_and_cardholder_id_and_card_id"

  create_table "games", :force => true do |t|
    t.string   "game_session"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "attacker"
    t.string   "defender_state"
    t.integer  "defender"
    t.integer  "trump"
  end

end
