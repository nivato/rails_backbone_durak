class Cardholder2
  
  @@cardholders = {
    "player"      => 1,
    "computer"    => 2,
    "deck"        => 3,
    "attacker"    => 4,
    "defender"    => 5
  }
  
  def self.player
    return @@cardholders["player"]
  end
  
  def self.computer
    return @@cardholders["computer"]
  end
  
  def self.deck
    return @@cardholders["deck"]
  end
  
  def self.attacker
    return @@cardholders["attacker"]
  end
  
  def self.defender
    return @@cardholders["defender"]
  end
  
  def self.get(id)
    return @@cardholders.key(id)
  end
  
end