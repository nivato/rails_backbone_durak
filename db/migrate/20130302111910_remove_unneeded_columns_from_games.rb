class RemoveUnneededColumnsFromGames < ActiveRecord::Migration
  
  def up
    remove_column "games", "attacker"
    remove_column "games", "defender"
    remove_column "games", "defender_state"
    remove_column "games", "trump"
    remove_column "games", "finished"
    remove_column "games", "message"
  end

  def down
    add_column "games", "attacker", :integer
    add_column "games", "defender", :integer
    add_column "games", "defender_state", :string
    add_column "games", "trump", :integer
    add_column "games", "finished", :boolean
    add_column "games", "message", :string
  end
  
end
