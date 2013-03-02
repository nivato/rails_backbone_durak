class Deck2
  
  @cards = []
  
  def initialize(cards)
    @cards = cards
  end
  
  def self.new_shuffled_deck
    cards = 1.upto(36).to_a
    return cards.shuffle!
  end
  
  def get_cards
    return @cards
  end
  
  def define_trump
    return @cards.last
  end
  
  def serve_cards(number_of_cards)
    cards_to_serve = @cards.first(number_of_cards)
    @cards = @cards.drop(cards_to_serve.size)
    return cards_to_serve
  end
  
end