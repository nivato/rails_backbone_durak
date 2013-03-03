class RemoveStateColumnFromGames < ActiveRecord::Migration
  
  def up
    remove_column "games", "state"
  end

  def down
    add_column "games", "state", :text
  end
  
end
