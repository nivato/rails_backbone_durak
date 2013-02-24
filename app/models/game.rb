class Game < ActiveRecord::Base
  attr_accessible :game_session, :attacker, :defender_state, :defender, :trump
  has_many :game_logs
  has_many :cardholders, :through => :game_logs
  has_many :cards, :through => :game_logs
  
  scope :for_session, lambda{|game_session| where(:game_session => game_session)}
  
  def self.switch_players(game)
    attacker_id = game.attacker
    defender_id = game.defender
    game.update_attributes(:attacker => defender_id, :defender => attacker_id, :defender_state => "continues")
  end
  
  def self.set_up_game
    pupulate_db
    game_session = Digest::SHA2.hexdigest("#{Time.now}")
    game = Game.create(:game_session => game_session)
    Deck.initiate(game)
    Deck.shuffle(game)
    game.update_attribute("trump", Deck.define_trump(game).id)
    Deck.serve_cards(game)
    define_attacker(game)
    game.update_attribute("defender_state", "continues")
    if game.computers_turn?
      Computer.play_card(game)
    end
    return game_session
  end
  
  def self.check_whether_game_is_finished(game)
    if ((Computer.get_cards(game) == []) || (Player.get_cards(game) == [])) && Deck.get_cards(game) == []
      game.update_attribute("finished", true)
    end
  end
  
  def computers_turn?
    return self.attacker == Cardholder.computer.first.id
  end
  
  def players_turn?
    return self.attacker == Cardholder.player.first.id
  end
  
  def get_trump
    return Card.find(self.trump)
  end
  
  private
  
  def self.define_attacker(game)
    # define who is attacking first basing on a lowest trump in hand
    player = Cardholder.player.first
    computer = Cardholder.computer.first
    players_lowest_trump = Player.choose_lowest_trump_card(Player.get_cards(game), game.get_trump)
    computers_lowest_trump = Computer.choose_lowest_trump_card(Computer.get_cards(game), game.get_trump)
    if (players_lowest_trump != nil) && (computers_lowest_trump != nil)
      if players_lowest_trump.rank_number < computers_lowest_trump.rank_number
        game.update_attribute("attacker", player.id)
        game.update_attribute("defender", computer.id)
      else
        game.update_attribute("attacker", computer.id)
        game.update_attribute("defender", player.id)
      end
    else
      if players_lowest_trump != nil
        game.update_attribute("attacker", player.id)
        game.update_attribute("defender", computer.id)
      else
        if computers_lowest_trump != nil
          game.update_attribute("attacker", computer.id)
          game.update_attribute("defender", player.id)
        else
          # if both player and computer do not have trump in hand, then player attacks firs
          game.update_attribute("attacker", player.id)
          game.update_attribute("defender", computer.id)
        end
      end
    end
  end
  
  def self.pupulate_db
    if Card.all == []
      pupulate_db_with_cards
    end
    if Cardholder.all == []
      populate_db_with_cardholders
    end
  end
  
  def self.pupulate_db_with_cards
    ranks = {
      6 => "6", 
      7 => "7", 
      8 => "8", 
      9 => "9", 
      10 => "10", 
      11 => "J", 
      12 => "Q", 
      13 => "K", 
      14 => "A"
    }
    suits = {
      "s" => "\u2660", #spades
      "h" => "\u2665", #hearts
      "d" => "\u2666", #diamonds
      "c" => "\u2663", #clubs
    }
    ranks.each do |rank_number, rank|
      suits.each do |suit_char, suit|
        card = Card.new
        card.rank = rank
        card.rank_number = rank_number
        card.suit = suit
        card.suit_char = suit_char
        card.save
      end
    end
  end
  
  def self.populate_db_with_cardholders
    ch_types = ["Player", "Computer", "Deck", "Table", "Pile"]
    ch_types.each do |ch_type|
      cardholder = Cardholder.new
      cardholder.ch_type = ch_type
      cardholder.save
    end
  end
  
end
