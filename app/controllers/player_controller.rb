class PlayerController < ApplicationController
  respond_to :json, :html
  # GET /player
  # GET /player.json
  def index
    game = Game.for_session(session[:game_session]).first
    respond_with Player.get_cards_marked_with_playable_flag(game), :only => [:id, :rank, :suit, :position, :playable]
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    card = Card.find(params[:id])
    game = Game.for_session(session[:game_session]).first
    Player.play_card(game, card)
    Computer.beat_card(game, card)
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
