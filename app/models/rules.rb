class Rules
  
  def self.get_higher_cards_of_same_suit(attackers_card, defender_cards)
    cards_of_higher_rank = []
    cards_of_same_suit = defender_cards.collect do |card|
      card if card.suit_char == attackers_card.suit_char
    end
    cards_of_same_suit.compact!
    unless cards_of_same_suit == []
      cards_of_higher_rank = cards_of_same_suit.collect do |card|
        card if card.rank_number > attackers_card.rank_number
      end
      cards_of_higher_rank.compact!
    end
    return cards_of_higher_rank
  end
  
  def self.get_cards_of_trump_suit(cards_in_hand, trump)
    cards_of_trump_suit = cards_in_hand.collect do |card|
      card if card.suit_char == trump.suit_char
    end
    return cards_of_trump_suit.compact!
  end
  
end