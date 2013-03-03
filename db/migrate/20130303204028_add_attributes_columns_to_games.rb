class AddAttributesColumnsToGames < ActiveRecord::Migration
  
  def up
    add_column "games", "player_cards",     :string,  :limit => 150
    add_column "games", "computer_cards",   :string,  :limit => 150
    add_column "games", "deck_cards",       :string,  :limit => 150
    add_column "games", "attacker_cards",   :string,  :limit => 50
    add_column "games", "defender_cards",   :string,  :limit => 50
    add_column "games", "trump",            :integer, :limit => 2
    add_column "games", "attacker",         :integer, :limit => 2
    add_column "games", "defender_state",   :string,  :limit => 10
    add_column "games", "game_finished",    :boolean
    add_column "games", "message",          :string,  :limit => 50
  end
  
  def down
    remove_column "games", "player_cards"
    remove_column "games", "computer_cards"
    remove_column "games", "deck_cards"
    remove_column "games", "attacker_cards"
    remove_column "games", "defender_cards"
    remove_column "games", "trump"
    remove_column "games", "attacker"
    remove_column "games", "defender_state"
    remove_column "games", "game_finished"
    remove_column "games", "message"
  end
  
end
