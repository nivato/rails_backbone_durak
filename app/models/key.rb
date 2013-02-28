class Key
  
  @@holders = {
    1   => "player_cards",
    2   => "computer_cards",
    3   => "deck_cards",
    4   => "attacker_cards",
    5   => "defender_cards",
    6   => "trump_card",
    7   => "attacker",
    8   => "defender",
    9   => "defender_state",
    10  => "game_finished",
    11  => "message"
  }
  
  def self.player_cards
    return @@holders[1]
  end
  
  def self.computer_cards
    return @@holders[2]
  end
  
  def self.deck_cards
    return @@holders[3]
  end
  
  def self.attacker_cards
    return @@holders[4]
  end
  
  def self.defender_cards
    return @@holders[5]
  end
  
  def self.trump_card
    return @@holders[6]
  end
  
  def self.attacker
    return @@holders[7]
  end
  
  def self.defender
    return @@holders[8]
  end
  
  def self.defender_state
    return @@holders[9]
  end
  
  def self.game_finished
    return @@holders[10]
  end
  
  def self.message
    return @@holders[11]
  end
  
  def self.id_for(holder)
    return @@holders.key(holder)
  end
  
end