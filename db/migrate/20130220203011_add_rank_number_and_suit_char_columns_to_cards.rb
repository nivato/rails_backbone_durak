class AddRankNumberAndSuitCharColumnsToCards < ActiveRecord::Migration
  
  def up
    add_column "cards", "rank_number", :integer
    add_column "cards", "suit_char", :string
  end
  
  def down
    remove_column "cards", "rank_number"
    remove_column "cards", "suit_char"
  end
  
end
