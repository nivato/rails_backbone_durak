class FixCardsColumnName < ActiveRecord::Migration
  
  def up
    rename_column("cards", "suite", "suit")
  end

  def down
    rename_column("cards", "suit", "suite")
  end
  
end
