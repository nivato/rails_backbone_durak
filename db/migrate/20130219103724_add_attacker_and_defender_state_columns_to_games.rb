class AddAttackerAndDefenderStateColumnsToGames < ActiveRecord::Migration
  
  def up
    add_column "games", "attacker", :integer
    # defender_state would be either "defeated" or "continues"
    add_column "games", "defender_state", :string
  end
  
  def down
    remove_column "games", "attacker"
    remove_column "games", "defender_state"
  end
  
end
