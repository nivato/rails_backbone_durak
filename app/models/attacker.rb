class Attacker
  
  def self.get_cards(game)
    table = Cardholder.table.first
    return table.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").where("game_logs.played_by = #{game.attacker}").order("game_logs.position ASC")
  end
  
  def self.get_logs(game)
    table = Cardholder.table.first
    return table.game_logs.where(:game_id => game.id, :played_by => game.attacker)
  end
  
  def self.get_cards_max_position(game)
    positions = get_logs(game).collect! {|log| log.position}
    return positions.max ? positions.max : 1
  end
  
end
