class Process
  
  @game = nil
  @player = nil
  @computer = nil
  @deck = nil
  @table = nil
  @trump = nil
  @attacker = nil
  @defender_state = nil
  @game_finished = nil
  @message = nil
  
  def initialize(game_session)
    unless game_session
      @game = Game.for_session(game_session).first
      state = JSON.parse(@game.state)
      @player = Player2.new(state[Key.player_cards])
      @computer = Computer2.new(state[Key.computer_cards])
      @deck = Deck2.new(state[Key.deck_cards])
      @table = Table2.new(state[Key.attacker_cards], state[Key.defender_cards])
      @trump = state[Key.trump]
      @attacker = Key.value_of(state[Key.attacker])
      @defender_state = Key.value_of(state[Key.defender_state])
      @game_finished = state[Key.game_finished]
      @message = state[Key.message]
    end
  end
  
  def set_up_game
    game_session = Digest::SHA2.hexdigest("#{Time.now}")
    @game = Game.create(:game_session => game_session)
    @deck = Deck2.new(Deck2.new_shuffled_deck)
    @trump = @deck.define_trump
    @player = Player2.new([])
    @computer = Computer2.new([])
    @player.receive_cards(@deck.serve_cards(@player.cards_required))
    @computer.receive_cards(@deck.serve_cards(@computer.cards_required))
    @attacker = define_attacker
    @defender_state = Key.continues
    @game_finished = false
    @message = nil
    
    
    if attacker == Key.computers
      Computer.play_card(game) #TODO Move from computer to process...
    end
    store
    return game_session
  end
  
  def define_attacker
    # define who is attacking first basing on a lowest trump in hand
    players_lowest_trump = @player.select_lowest_trump_card(@player.get_cards, @trump)
    computers_lowest_trump = @computer.select_lowest_trump_card(@computer.get_cards, @trump)
    if (players_lowest_trump != nil) && (computers_lowest_trump != nil)
      if Card2.rank_number(players_lowest_trump) < Card2.rank_number(computers_lowest_trump)
        return Key.player
      else
        return Key.computer
      end
    else
      if players_lowest_trump != nil
        return Key.player
      else
        if computers_lowest_trump != nil
          return Key.computer
        else
          # if both player and computer do not have trump in hand, then player attacks firs
          return Key.player
        end
      end
    end
  end
  
  def store
    state = {}
    state[Key.deck_cards] = @deck.get_cards
    state[Key.player_cards] = @player.get_cards
    state[Key.computer_cards] = @computer.get_cards
    state[Key.attacker_cards] = @table.get_attacker_cards
    state[Key.defender_cards] = @table.get_defender_cards
    state[Key.trump] = @trump
    state[Key.attacker] = Key.id_for(@attacker)
    state[Key.defender_state] = Key.id_for(@defender_state)
    state[Key.game_finished] = @game_finished
    state[Key.message] = @message
    @game..update_attribute("state", state.as_json)
  end
  
end