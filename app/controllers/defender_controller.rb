class DefenderController < ApplicationController
  respond_to :json, :html
  # GET /defender
  # GET /defender.json
  def index
    game = Game.for_session(session[:game_session]).first
    table = Cardholder.table.first
    @defender_cards = table.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").where("game_logs.played_by = #{game.defender}").order("game_logs.position ASC")
    respond_with @defender_cards, :only => [:rank, :suit, :position]
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
