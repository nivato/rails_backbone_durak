class Rules
  
  def self.get_cards(game)
    # overriden in Player and Computer
  end
  
  def self.take_cards_from_table(game)
    positions = get_cards(game).collect! {|card| card.position}
    max_position = positions.max ? positions.max : 0
    Table.get_logs(game).each do |log|
      log.update_attributes(:cardholder_id => game.defender, :played_by => nil, :position => max_position += 1)
    end
    game.update_attributes(:defender_state => "continues")
  end
  
  def self.get_higher_cards_of_same_suit(attackers_card, defender_cards)
    cards_of_higher_rank = []
    cards_of_same_suit = defender_cards.collect do |card|
      card if card.suit_char == attackers_card.suit_char
    end
    cards_of_same_suit = cards_of_same_suit.compact
    unless cards_of_same_suit == []
      cards_of_higher_rank = cards_of_same_suit.collect do |card|
        card if card.rank_number > attackers_card.rank_number
      end
    end
    return cards_of_higher_rank.compact
  end
  
  def self.get_cards_of_trump_suit(cards_in_hand, trump)
    cards_of_trump_suit = cards_in_hand.collect do |card|
      card if card.suit_char == trump.suit_char
    end
    return cards_of_trump_suit.compact
  end
  
  def self.get_cards_of_same_ranks(cards_on_table, own_cards)
    cards_of_same_rank = []
    table_ranks = cards_on_table.collect{|card| card.rank}
    own_cards.each do |card|
      if table_ranks.include? card.rank
        cards_of_same_rank << card
      end
    end
    return cards_of_same_rank
  end
  
end