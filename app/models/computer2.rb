class Computer2 < Rules2
  
  @cards = []
  
  def initialize(cards)
    @cards = cards
  end
  
  def get_cards
    return @cards
  end
  
  def receive_cards(cards)
    @cards = @cards + cards
  end
  
  def cards_required
    cards_required = 6 - get_cards.size
    return cards_required >= 0 ? cards_required : 0
  end
  
  def play_card(card)
    @cards.delete(card)
  end
  
  def choose_attacking_card(cards_on_table, trump)
    attacking_card = nil
    if cards_on_table == []
      cards_of_not_trump_suit = @cards.collect do |card|
        card if Card2.suit(card) != Card2.suit(trump)
      end
      cards_of_not_trump_suit = cards_of_not_trump_suit.compact
      if cards_of_not_trump_suit != []
        ranks = cards_of_not_trump_suit.collect do |card|
          Card2.rank_number(card)
        end
        ranks = ranks.uniq
        min_rank = ranks.to_a.min
        cards_of_not_trump_suit.each do |card|
          attacking_card = card if Card2.rank_number(card) == min_rank
        end
      else
        attacking_card = select_lowest_trump_card(@cards, trump)
      end
    else
      attacking_card = get_cards_of_same_ranks(cards_on_table, @cards).first
    end
    return attacking_card
  end
  
  def choose_defending_card(attackers_card, trump)
    defenders_card = nil
    if Card2.suit(attackers_card) == Card2.suit(trump)
      defenders_card = choose_higher_card_of_same_suit(attackers_card)
    else
      defenders_card = choose_higher_card_or_trump(attackers_card, trump)
    end
    return defenders_card
  end
  
  def choose_higher_card_or_trump(attackers_card, trump)
    defenders_card = choose_higher_card_of_same_suit(attackers_card)
    unless defenders_card == nil
      defenders_card = select_lowest_trump_card(trump)
    end
    return defenders_card
  end
    
  def choose_higher_card_of_same_suit(player_card)
    defenders_card = nil
    cards_of_higher_rank = select_higher_cards_of_same_suit(player_card)
    unless cards_of_higher_rank == []
      defenders_card = select_lowest_card(cards_of_higher_rank)
    end
    return defenders_card
  end
  
end