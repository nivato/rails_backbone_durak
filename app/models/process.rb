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
      make_computer_play
    end
    store
    return game_session
  end
  
  def accept_players_action(card)
    if @attacker == Key.player
      @player.play_card(card)
      check_whether_game_is_finished
      unless @game_finished || @defender_state == Key.defeated
        make_computer_beat_the_card(card)
      end
    else
      @player.play_card(card)
      @table.receive_defending_card(card)
      check_whether_game_is_finished
      unless @game_finished
        make_computer_play
      end
    end  
  end
  
  def make_computer_beat_the_card(attackers_card)
    computer_cards = get_cards(game)
    defenders_card = @computer.choose_defending_card(attackers_card, @trump)
    if defenders_card != nil
      @computer.play_card(defenders_card)
      @table.receive_defending_card(defenders_card)
      if get_players_playable_cards == []
        @defender_state = Key.won
      end
    else
      @defender_state = Key.defeated
    end
    check_whether_game_is_finished
  end
  
  def get_message
    message_hash = {}
    unless @message == nil
      message_hash[Key.message] = @message
      message_hash["id"] = 1
    end
    return message_hash
  end
  
  def make_computer_play
    attackers_card = @computer.choose_attacking_card(@table.get_cards, @trump)
    if (attackers_card != nil) && @player.has_cards? && !(@table.get_attacker_cards.size >= 6)
      @computer.play_card(attackers_card)
      @table.receive_attacking_card(attackers_card)
      if get_players_playable_cards == []
        @defender_state = Key.defeated
      end
    else
      @defender_state = Key.won
    end
    check_whether_game_is_finished
  end
  
  def check_whether_game_is_finished
    if ((@computer.get_cards == []) || (@player.get_cards == [])) && @deck.get_cards == []
      if @computer.get_cards == []
        @message = "Computer won!"
      else
        @message = "Player won!"
      end
      @game_finished = true
    end
  end
  
  def get_players_playable_cards
    if !@game_finished
      player_cards = @player.get_cards
      if @attacker == Key.player
        if @computer.has_cards? && !(@table.get_attacker_cards.size >= 6)
          if @table.get_cards == []
            return player_cards
          else
            return @player.get_cards_of_same_ranks(table_cards)
          end
        else
          return []
        end
      else
        if (@defender_state == Key.continues)
          attackers_card = @table.get_attacker_cards.last
          if Card2.suit(attackers_card) != Card2.suit(@trump)
            return @player.select_higher_cards_of_same_suit(attackers_card) + @player.select_cards_of_trump_suit(@trump)
          else
            return @player.select_higher_cards_of_same_suit(attackers_card)
          end
        else
          return []
        end
      end
    else
      return []
    end
  end  
  
  def define_attacker
    # define who is attacking first basing on a lowest trump in hand
    players_lowest_trump = @player.select_lowest_trump_card(@trump)
    computers_lowest_trump = @computer.select_lowest_trump_card(@trump)
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
    @game.update_attribute("state", state.as_json)
  end
  
end