class TrumpController < ApplicationController
  respond_to :json, :html
  # GET /attacker
  # GET /attacker.json
  def index
    game = Game.for_session(session[:game_session]).first
    @trump = Card.find(game.trump)
    respond_with @trump
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