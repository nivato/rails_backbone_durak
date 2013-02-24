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
    
    # TODO case when player click take_cards havin playable cards
    
    game = Game.for_session(session[:game_session]).first
    if game.finished
      session[:game_session] = Game.set_up_game
      game = Game.for_session(session[:game_session]).first
    else
      if (game.defender_state == "won") || (game.defender_state == "continues")
        Table.throw_out_cards_to_pile(game)
        Game.switch_players(game)
      else
        if game.players_turn?
          Computer.take_cards_from_table(game)
        else
          Player.take_cards_from_table(game)
        end
      end
      Deck.serve_cards(game)
      if game.computers_turn?
        Computer.play_card(game)
      end
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
