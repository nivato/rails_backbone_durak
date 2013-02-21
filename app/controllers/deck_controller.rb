class DeckController < ApplicationController
  respond_to :json, :html
  # GET /deck
  # GET /deck.json
  def index
    game = Game.for_session(session[:game_session]).first
    deck = Cardholder.deck.first
    @cards_in_deck = deck.cards.where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
    respond_with @cards_in_deck, :only => [:rank, :suit, :position]
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
