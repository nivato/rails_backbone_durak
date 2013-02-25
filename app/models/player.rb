class Player < Rules
  
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
    Game.check_whether_game_is_finished(game)
  end
  
  def self.beat_with(game, card)
    player = Cardholder.player.first
    game_log = player.game_logs.where(:game_id => game.id, :card_id => card.id).first
    table = Cardholder.table.first
    position = Defender.get_cards_max_position(game) + 1
    game_log.update_attributes(:cardholder_id => table.id, :played_by => player.id, :position => position)
    Game.check_whether_game_is_finished(game)
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
    if !game.finished
      player_cards = get_cards(game)
      if game.players_turn?
        if Computer.has_cards?(game) && !(Attacker.get_cards(game).size >= 6)
          table = Cardholder.table.first
          table_cards = table.cards.where("game_logs.game_id = #{game.id}")
          if table_cards == []
            return player_cards
          else
            return get_cards_of_same_ranks(table_cards, player_cards)
          end
        else
          return []
        end
      else
        if (game.defender_state == "continues")
          attackers_card = Attacker.get_cards(game).last
          trump = game.get_trump
          if attackers_card.suit_char != trump.suit_char
            return get_higher_cards_of_same_suit(attackers_card, player_cards) + get_cards_of_trump_suit(player_cards, trump)
          else
            return get_higher_cards_of_same_suit(attackers_card, player_cards)
          end
        else
          return []
        end
      end
    else
      return []
    end
  end  
  
end
