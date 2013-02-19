class AddDefenderColumnToGames < ActiveRecord::Migration
  
  def up
    add_column "games", "defender", :integer
  end
  
  def down
    remove_column "games", "defender"
  end
  
end
