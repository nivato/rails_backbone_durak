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
    respond_with @buttons
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

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    respond_with []
  end
end
