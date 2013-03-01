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
  
  def throw_card_away(card)
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
  
end