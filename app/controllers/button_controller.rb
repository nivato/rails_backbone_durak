class ButtonController < ApplicationController
  respond_to :json, :html
  # GET /button
  # GET /button.json
  def index
    game = Game.for_session(session[:game_session]).first
    player = Cardholder.player.first
    computer = Cardholder.computer.first
    table = Cardholder.table.first
    table_cards = table.cards.where("game_logs.game_id = #{game.id}")
    @buttons = {}
    if ((game.attacker == player.id) && (table_cards != [])) || ((game.attacker == computer.id) && (game.defender_state == "won"))
      @buttons["next"] = true
    else
      @buttons["next"] = false
    end
    if (game.attacker == computer.id) && ((game.defender_state == "continues") || (game.defender_state == "defeated")) && (table_cards != [])
      @buttons["take_cards"] = true
    else
      @buttons["take_cards"] = false
    end
    @buttons["id"] = 1
    respond_with @buttons
  end
  
  # DELETE /buttons/1
  # DELETE /buttons/1.json
  def destroy
    game = Game.for_session(session[:game_session]).first
    table = Cardholder.table.first
    pile = Cardholder.pile.first
    if (game.defender_state == "won") || (game.defender_state == "continues")
      game_logs = table.game_logs.where(:game_id => game.id)
      game_logs.each do |game_log|
        game_log.update_attributes(:cardholder_id => pile.id, :played_by => nil, :beated_with => nil, :position => 0)
      end
      # switch defender and attacker places
      attacker_id = game.attacker
      defender_id = game.defender
      game.update_attributes(:attacker => defender_id, :defender => attacker_id, :defender_state => "continues")
      Deck.serve_cards(game)
    else
      defender = Cardholder.find(game.defender)
      game_logs = table.game_logs.where(:game_id => game.id)
      positions = defender.game_logs.where(:game_id => game.id)
      positions.collect! {|log| log.position}
      max_position = positions.max ? positions.max : 1
      game_logs.each do |game_log|
        game_log.update_attributes(:cardholder_id => game.defender, :played_by => nil, :beated_with => nil, :position => max_position += 1)
      end
      game.update_attributes(:defender_state => "continues")
      Deck.serve_cards(game)
    end
    respond_with []
  end
  
  # GET /decks/1
  # GET /decks/1.json
  def show
    respond_with []
  end

  # GET /decks/new
  # GET /decks/new.json
  def new
    respond_with []
  end

  # GET /decks/1/edit
  def edit
    respond_with []
  end

  # POST /decks
  # POST /decks.json
  def create
    respond_with []
  end

  # PUT /decks/1
  # PUT /decks/1.json
  def update
    respond_with []
  end
  
end
