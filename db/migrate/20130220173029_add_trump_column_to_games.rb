class AddTrumpColumnToGames < ActiveRecord::Migration
  
  def up
    add_column "games", "trump", :integer
  end
  
  def down
    remove_column "games", "trump"
  end
  
end
