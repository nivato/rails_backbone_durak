class GameProcess
  
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
    unless game_session == nil
      @game = Game.for_session(game_session).first
      @player = Player.new(JSON.parse(@game.player_cards))
      @computer = Computer.new(JSON.parse(@game.computer_cards))
      @deck = Deck.new(JSON.parse(@game.deck_cards))
      @table = Table.new(JSON.parse(@game.attacker_cards), JSON.parse(@game.defender_cards))
      @trump = @game.trump
      @attacker = Key.value(@game.attacker)
      @defender_state = Key.value(@game.defender_state)
      @game_finished = @game.game_finished
      @message = @game.message
    end
  end
  
  def set_up_game
    game_session = Digest::SHA2.hexdigest("#{Time.now}")
    @game = Game.create(:game_session => game_session)
    @deck = Deck.new(Deck.new_shuffled_deck)
    @trump = @deck.define_trump
    @player = Player.new([])
    @computer = Computer.new([])
    @player.receive_cards(@deck.serve_cards(@player.cards_required))
    @computer.receive_cards(@deck.serve_cards(@computer.cards_required))
    @attacker = define_attacker
    @defender_state = Key.continues
    @table = Table.new([], [])
    @game_finished = false
    @message = nil
    if @attacker == Key.computer
      make_computer_play
    end
    store
    return game_session
  end
  
  def accept_players_button_action
    if @game_finished
      game_session = GameProcess.new(nil).set_up_game
      return game_session
    else
      if (@defender_state == Key.won) || (@defender_state == Key.continues)
        if @table.get_attacker_cards.size > @table.get_defender_cards.size
          if @attacker == Key.player
            @computer.receive_cards(@table.clear)
          else
            @player.receive_cards(@table.clear)
          end
        else
          @table.clear
          if @attacker == Key.player
            @attacker = Key.computer
          else
            @attacker = Key.player
          end
        end
      else
        if @attacker == Key.player
          @computer.receive_cards(@table.clear)
        else
          @player.receive_cards(@table.clear)
        end
      end
      @defender_state = Key.continues
      if @attacker == Key.player
        @computer.receive_cards(@deck.serve_cards(@computer.cards_required))
        @player.receive_cards(@deck.serve_cards(@player.cards_required))
      else
        @player.receive_cards(@deck.serve_cards(@player.cards_required))
        @computer.receive_cards(@deck.serve_cards(@computer.cards_required))
        make_computer_play
      end
    end
    store
    return nil
  end
  
  def accept_players_card_action(card)
    if @attacker == Key.player
      @player.play_card(card)
      @table.receive_attacking_card(card)
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
    store
  end
  
  def get_player_rich_cards
    player_cards = @player.get_cards
    size = player_cards.size
    playable_cards = get_players_playable_cards
    rich_cards = []
    player_cards.each do |card_id|
      card = {}
      card["id"] = card_id
      card["card_class"] = "card-#{Card.rank(card_id) + Card.suit(card_id)}"
      card["size"] = size
      if playable_cards.include? card_id
        card["playable"] = true
      else
        card["playable"] = false
      end
      rich_cards << card
    end
    return rich_cards
  end
  
  def get_attacker_rich_cards
    attacker_cards = @table.get_attacker_cards
    rich_cards = []
    attacker_cards.each do |card_id|
      card = {}
      card["id"] = card_id
      card["card_class"] = "card-#{Card.rank(card_id) + Card.suit(card_id)}"
      rich_cards << card
    end
    return rich_cards
  end
  
  def get_defender_rich_cards
    defender_cards = @table.get_defender_cards
    rich_cards = []
    defender_cards.each do |card_id|
      card = {}
      card["id"] = card_id
      card["card_class"] = "card-#{Card.rank(card_id) + Card.suit(card_id)}"
      rich_cards << card
    end
    return rich_cards
  end
  
  def get_computer_cards_number
    computer_cards_number = {}
    computer_cards_number["size"] = @computer.get_cards.size
    computer_cards_number["id"] = 1
    return computer_cards_number
  end
  
  def get_deck_cards
    deck_cards = {}
    deck_cards["size"] = @deck.get_cards.size
    deck_cards["trump_class"] = "card-#{Card.rank(@trump) + Card.suit(@trump)}"
    deck_cards["id"] = 1
    return deck_cards
  end
  
  def get_buttons
    table_cards = @table.get_cards
    buttons = {}
    if ((@attacker == Key.player) && (table_cards != [])) || ((@attacker == Key.computer) && (@defender_state == Key.won))
      buttons["next"] = true
    else
      buttons["next"] = false
    end
    if (@attacker == Key.computer) && ((@defender_state == Key.continues) || (@defender_state == Key.defeated)) && (table_cards != [])
      buttons["take_cards"] = true
    else
      buttons["take_cards"] = false
    end
    if @game_finished
      buttons["new_game"] = true
      buttons["next"] = false
      buttons["take_cards"] = false
    else
      buttons["new_game"] = false
    end
    buttons["id"] = 1
    return buttons
  end
  
  def get_message
    message_hash = {}
    unless @message == nil
      message_hash[Key.message] = @message
      message_hash["id"] = 1
    end
    return message_hash
  end
  
  private
  
  def make_computer_beat_the_card(attackers_card)
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
            return @player.get_cards_of_same_ranks(@table.get_cards)
          end
        else
          return []
        end
      else
        if (@defender_state == Key.continues)
          attackers_card = @table.get_attacker_cards.last
          if Card.suit(attackers_card) != Card.suit(@trump)
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
      if Card.rank_number(players_lowest_trump) < Card.rank_number(computers_lowest_trump)
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
    @game.update_attributes(
      :deck_cards       => @deck.get_cards.to_s,
      :player_cards     => @player.get_cards.to_s,
      :computer_cards   => @computer.get_cards.to_s,
      :attacker_cards   => @table.get_attacker_cards.to_s,
      :defender_cards   => @table.get_defender_cards.to_s,
      :trump            => @trump,
      :attacker         => Key.id(@attacker),
      :defender_state   => Key.id(@defender_state),
      :game_finished    => @game_finished,
      :message          => @message
    )
  end
  
end