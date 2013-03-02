class PlayerController < ApplicationController
  respond_to :json, :html
  # GET /player
  # GET /player.json
  def index
    respond_with GameProcess.new(session[:game_session]).get_player_rich_cards
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    GameProcess.new(session[:game_session]).accept_players_card_action(params[:id].to_i)
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
