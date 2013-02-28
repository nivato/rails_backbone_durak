class AddStateColumnToGames < ActiveRecord::Migration
  
  def up
    add_column "games", "state", :string
  end
  
  def down
    remove_column "games", "state"
  end
  
end
