class Player2 < Rules2
  
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
  
  def play_card(card)
    @cards.delete(card)
  end
  
  def cards_required
    cards_required = 6 - get_cards.size
    return cards_required >= 0 ? cards_required : 0
  end
  
end