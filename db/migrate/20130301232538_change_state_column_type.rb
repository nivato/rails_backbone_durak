class ChangeStateColumnType < ActiveRecord::Migration
  
  def up
    change_column("games", "state", :text)
  end

  def down
    change_column("games", "state", :string)
  end
  
end
