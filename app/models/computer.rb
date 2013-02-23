class Computer
  
  def self.get_cards(game)
    computer = Cardholder.computer.first
    return computer.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
  end
  
  def self.beat_card(game, attackers_card)
    computer_cards = get_cards(game)
    defenders_card = choose_defending_card(attackers_card, computer_cards, Deck.get_trump(game))
    if defenders_card != nil
      computer = Cardholder.computer.first
      game_log = computer.game_logs.where(:game_id => game.id, :card_id => defenders_card.id).first
      table = Cardholder.table.first
      game_log.update_attributes(:cardholder_id => table.id, :played_by => computer.id, :position => Defender.get_cards_max_position(game) + 1)
      if Player.get_playable_cards(game) == []
        game.update_attribute("defender_state", "won")
      end
    else
      game.update_attribute("defender_state", "defeated")
    end
  end
  
  def self.play_card(game)
    computer_cards = get_cards(game)
    cards_on_table = Table.get_cards(game)
    attackers_card = choose_attacking_card(cards_on_table, computer_cards, Deck.get_trump(game))
    if attackers_card != nil
      computer = Cardholder.computer.first
      game_log = computer.game_logs.where(:game_id => game.id, :card_id => attackers_card.id).first
      table = Cardholder.table.first
      game_log.update_attributes(:cardholder_id => table.id, :played_by => computer.id, :position => Attacker.get_cards_max_position(game) + 1)
    else
      # COMPUTER WINS THE GAME!
    end
  end
  
  private
  
  def self.choose_attacking_card(cards_on_table, computer_cards, trump)
    attackers_card = nil
    if cards_on_table == []
      cards_of_not_trump_suit = computer_cards.collect do |card|
        card if card.suit_char != trump.suit_char
      end
      cards_of_not_trump_suit.compact!
      if cards_of_not_trump_suit != []
        ranks = cards_of_not_trump_suit.collect do |card|
          card.rank_number
        end
        min_rank = ranks.to_a.min
        cards_of_not_trump_suit.each do |card|
          attackers_card = card if card.rank_number == min_rank
        end
      else
        attackers_card = choose_lowest_trump_card(computer_cards, trump)
      end
    else
      # select card of same rank on table
    end
    return attackers_card
  end
  
  def self.choose_defending_card(attackers_card, computer_cards, trump)
    defenders_card = nil
    if attackers_card.suit_char == trump.suit_char
      defenders_card = choose_higher_card_of_same_suit(attackers_card, computer_cards)
    else
      defenders_card = choose_higher_card_or_trump(attackers_card, computer_cards, trump)
    end
    return defenders_card
  end
  
  def self.choose_higher_card_or_trump(attackers_card, computer_cards, trump)
    defenders_card = choose_higher_card_of_same_suit(attackers_card, computer_cards)
    unless defenders_card
      defenders_card = choose_lowest_trump_card(computer_cards, trump)
    end
    return defenders_card
  end
    
  def self.choose_higher_card_of_same_suit(attackers_card, computer_cards)
    defenders_card = nil
    cards_of_same_suit = computer_cards.collect do |card|
      card if card.suit_char == attackers_card.suit_char
    end
    cards_of_same_suit.compact!
    unless cards_of_same_suit == []
      cards_of_higher_rank = cards_of_same_suit.collect do |card|
        card if card.rank_number > attackers_card.rank_number
      end
      cards_of_higher_rank.compact!
      unless cards_of_higher_rank == []
        ranks = cards_of_higher_rank.collect do |card|
          card.rank_number
        end
        min_rank = ranks.to_a.min
        cards_of_higher_rank.each do |card|
          defenders_card = card if card.rank_number == min_rank
        end
      end
    end
    return defenders_card
  end
  
  def self.choose_lowest_trump_card(computer_cards, trump)
    lowest_trump_card = nil
    cards_of_trump_suit = computer_cards.collect do |card|
      card if card.suit_char == trump.suit_char
    end
    cards_of_trump_suit.compact!
    unless cards_of_trump_suit == []
      ranks = cards_of_trump_suit.collect do |card|
        card.rank_number
      end
      min_rank = ranks.to_a.min
      cards_of_trump_suit.each do |card|
        lowest_trump_card = card if card.rank_number == min_rank
      end
    end
    return lowest_trump_card
  end
  
end
