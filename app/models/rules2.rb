class Rules2
  
  def get_cards
    # overriden in Player and Computer
  end
  
  def has_cards?
    return get_cards.size > 0
  end
  
  def select_higher_cards_of_same_suit(attackers_card)
    cards_of_higher_rank = []
    cards_of_same_suit = get_cards.collect do |card|
      card if Card2.suit(card) == Card2.suit(attackers_card)
    end
    cards_of_same_suit = cards_of_same_suit.compact
    unless cards_of_same_suit == []
      cards_of_higher_rank = cards_of_same_suit.collect do |card|
        card if Card2.rank_number(card) > Card2.rank_number(attackers_card)
      end
    end
    return cards_of_higher_rank.compact
  end
  
  def select_cards_of_trump_suit(trump)
    cards_of_trump_suit = get_cards.collect do |card|
      card if Card2.suit(card) == Card2.suit(trump)
    end
    return cards_of_trump_suit.compact
  end
  
  def get_cards_of_same_ranks(cards_on_table)
    cards_of_same_rank = []
    table_ranks = cards_on_table.collect{|card| Card2.rank_number(card)}
    table_ranks = table_ranks.uniq
    get_cards.each do |card|
      if table_ranks.include? Card2.rank_number(card)
        cards_of_same_rank << card
      end
    end
    return cards_of_same_rank
  end
  
  def select_lowest_trump_card(trump)
    lowest_trump_card = nil
    cards_of_trump_suit = select_cards_of_trump_suit(trump)
    unless cards_of_trump_suit == []
      lowest_trump_card = select_lowest_card(cards_of_trump_suit)
    end
    return lowest_trump_card
  end
  
  def select_lowest_card(cards_in_hand)
    lowest_card = nil
    ranks = cards_in_hand.collect do |card|
      Card2.rank_number(card)
    end
    ranks = ranks.uniq
    min_rank = ranks.to_a.min
    cards.each do |card|
      lowest_card = card if Card2.rank_number(card) == min_rank
    end
    return lowest_card
  end
  
end