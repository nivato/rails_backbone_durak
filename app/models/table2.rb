class Table2
  
  @attacker_cards = []
  @defener_cards = []
  
  def initialize(attacker_cards, defener_cards)
    @attacker_cards = attacker_cards
    @defener_cards = defener_cards
  end
  
  def get_cards
    return @attacker_cards + @defener_cards
  end
  
  def get_attacker_cards
    return @attacker_cards
  end
  
  def get_defender_cards
    return @defener_cards
  end
  
  def receive_attacking_card(card)
    @attacker_cards << card
  end
  
  def receive_defending_card(card)
    @defener_cards << card
  end
  
  def clear
    cards_cleared = get_cards
    @attacker_cards = []
    @defener_cards = []
    return cards_cleared
  end
  
end
