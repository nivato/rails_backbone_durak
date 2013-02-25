class AddMessageColumnToGames < ActiveRecord::Migration
  
  def up
    add_column "games", "message", :string
  end
  
  def down
    remove_column "games", "message"
  end
  
end
