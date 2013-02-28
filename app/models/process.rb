class Process
  
  @game = nil
  @player = nil
  @computer = nil
  @deck = nil
  @attacker = nil
  @defender = nil
  @table = nil
  
  def initialize(game_session)
    @game = Game.for_session(game_session).first
  end
  
  def self.set_up_game
    game_session = Digest::SHA2.hexdigest("#{Time.now}")
    state = {}
    state[Key.deck_cards] = []
    state[Key.player_cards] = []
    state[Key.computer_cards] = []
    state[Key.attacker_cards] = []
    state[Key.defender_cards] = []
    state[Key.trump_card] = nil
    state[Key.attacker] = nil
    state[Key.defender] = nil
    state[Key.defender_state] = nil
    state[Key.game_finished] = nil
    state[Key.message] = nil
    
    deck = Deck2.new(Deck2.new_shuffled_deck)
    trump = deck.define_trump
    player = Player2.new([])
    computer = Computer2.new([])
    player.receive_cards(deck.serve_cards(player.cards_required))
    computer.receive_cards(deck.serve_cards(computer.cards_required))
    
    game = Game.create(:game_session => game_session)
    define_attacker(game)
    game.update_attribute("defender_state", "continues")
    game.update_attribute("message", nil)
    if game.computers_turn?
      Computer.play_card(game)
    end
    return game_session
  end
  
  def self.define_attacker(player, computer)
    # define who is attacking first basing on a lowest trump in hand
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
  
end