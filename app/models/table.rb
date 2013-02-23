class Table
  
  def self.get_cards(game)
    table = Cardholder.table.first
    return table.cards.where("game_logs.game_id = #{game.id}")
  end
  
  def self.get_logs(game)
    table = Cardholder.table.first
    return table.game_logs.where(:game_id => game.id)
  end
  
  def self.throw_out_cards_to_pile(game)
    pile = Cardholder.pile.first
    get_logs(game).each do |log|
        log.update_attributes(:cardholder_id => pile.id, :played_by => nil, :position => 0)
      end
  end
  
end
