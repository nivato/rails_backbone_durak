class Defender
  
  def self.get_cards(game)
    table = Cardholder.table.first
    return table.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").where("game_logs.played_by = #{game.defender}").order("game_logs.position ASC")
  end
  
  def self.get_logs(game)
    defender = Cardholder.find(game.defender)
    return defender.game_logs.where(:game_id => game.id)
  end
  
  def self.get_cards_max_position(game)
    positions = get_logs(game).collect! {|log| log.position}
    return positions.max ? positions.max : 1
  end
  
  def self.take_cards_from_table(game)
    positions = get_logs(game).collect! {|log| log.position}
    max_position = positions.max ? positions.max : 1
    Table.get_logs(game).each do |log|
      log.update_attributes(:cardholder_id => game.defender, :played_by => nil, :beated_with => nil, :position => max_position += 1)
    end
    game.update_attributes(:defender_state => "continues")
  end
  
end
