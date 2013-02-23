class ButtonController < ApplicationController
  respond_to :json, :html
  # GET /button
  # GET /button.json
  def index
    game = Game.for_session(session[:game_session]).first
    respond_with Button.get_buttons(game)
  end
  
  # DELETE /buttons/1
  # DELETE /buttons/1.json
  def destroy
    game = Game.for_session(session[:game_session]).first
    if (game.defender_state == "won") || (game.defender_state == "continues")
      Table.throw_out_cards_to_pile(game)
      Game.switch_players(game)
      Deck.serve_cards(game)
      if game.computers_turn?
        Computer.play_card(game)
      end
    else
      Defender.take_cards_from_table(game)
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
