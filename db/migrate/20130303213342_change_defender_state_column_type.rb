class ChangeDefenderStateColumnType < ActiveRecord::Migration
  
  def up
    change_column("games", "defender_state", :integer, :limit => 2)
  end

  def down
    change_column("games", "defender_state", :string, :limit => 10)
  end
end
