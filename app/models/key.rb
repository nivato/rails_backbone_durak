class Key
  
  @@keys = {
    1   => "player_cards",
    2   => "computer_cards",
    3   => "deck_cards",
    4   => "attacker_cards",
    5   => "defender_cards",
    6   => "trump",
    7   => "attacker",
    8   => "defender_state",
    9   => "game_finished",
    10  => "message",
    11  => "player",
    12  => "computer",
    13  => "continues",
    14  => "won",
    15  => "defeated"
  }
  
  def self.player_cards
    return @@keys[1]
  end
  
  def self.computer_cards
    return @@keys[2]
  end
  
  def self.deck_cards
    return @@keys[3]
  end
  
  def self.attacker_cards
    return @@keys[4]
  end
  
  def self.defender_cards
    return @@keys[5]
  end
  
  def self.trump
    return @@keys[6]
  end
  
  def self.attacker
    return @@keys[7]
  end
  
  def self.defender_state
    return @@keys[8]
  end
  
  def self.game_finished
    return @@keys[9]
  end
  
  def self.message
    return @@keys[10]
  end
  
  def self.player
    return @@keys[11]
  end
  
  def self.computer
    return @@keys[12]
  end
  
  def self.continues
    return @@keys[13]
  end
  
  def self.won
    return @@keys[14]
  end
  
  def self.defeated
    return @@keys[15]
  end
  
  def self.id_for(value)
    return @@keys.key(value)
  end
  
  def self.value_of(id)
    return @@keys[id]
  end
  
end