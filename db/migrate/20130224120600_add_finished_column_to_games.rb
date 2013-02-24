class AddFinishedColumnToGames < ActiveRecord::Migration
  
  def up
    add_column "games", "finished", :boolean, :default => false
  end
  
  def down
    remove_column "games", "finished"
  end
  
end
