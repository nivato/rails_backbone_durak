class AddGameSessionIndexToGames < ActiveRecord::Migration
  
  def up
    add_index("games", "game_session")
  end
  
  def down
    remove_index("games", "game_session")
  end
  
end
