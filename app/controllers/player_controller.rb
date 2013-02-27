class PlayerController < ApplicationController
  respond_to :json, :html
  # GET /player
  # GET /player.json
  def index
    game = Game.for_session(session[:game_session]).first
    player_cards = Player.get_cards_marked_with_playable_flag(game)
    size = player_cards.size
    player_cards.each() do |card|
      card["size"] = size
    end
    respond_with player_cards, :only => [:id, :rank, :suit_char, :size, :playable]
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    card = Card.find(params[:id])
    game = Game.for_session(session[:game_session]).first
    if game.players_turn?
      Player.play_card(game, card)
      unless game.finished || game.defender_state == "defeated"
        Computer.beat_card(game, card)
      end
    else
      Player.beat_with(game, card)
      unless game.finished
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
