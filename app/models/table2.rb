class Table
  
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
  
end
