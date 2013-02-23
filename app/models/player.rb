class Player
  
  def self.get_cards(game)
    player = Cardholder.player.first
    return player.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
  end
  
  def self.play_card(game, card)
    player = Cardholder.player.first
    game_log = player.game_logs.where(:game_id => game.id, :card_id => card.id).first
    table = Cardholder.table.first
    position = Attacker.get_cards_max_position(game) + 1
    game_log.update_attributes(:cardholder_id => table.id, :played_by => player.id, :position => position)
  end
  
  def self.get_cards_marked_with_playable_flag(game)
    player_cards = get_cards(game)
    playable_card_ids = Player.get_playable_cards(game).collect{|card| card.id}
    player_cards.each do |card|
      if playable_card_ids.include? card.id
        card["playable"] = true
      else
        card["playable"] = false
      end
    end
    return player_cards
  end
  
  def self.get_playable_cards(game)
    player_cards = get_cards(game)
    table = Cardholder.table.first
    table_cards = table.cards.where("game_logs.game_id = #{game.id}")
    if table_cards == []
      return player_cards
    else
      table_ranks = table_cards.collect{|card| card.rank}
      playable_cards = []
      player_cards.each do |card|
        if table_ranks.include? card.rank
          playable_cards << card
        end
      end
      return playable_cards
    end
  end  
  
end
