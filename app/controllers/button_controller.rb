class ButtonController < ApplicationController
  respond_to :json, :html
  # GET /button
  # GET /button.json
  def index
    respond_with GameProcess.new(session[:game_session]).get_buttons
  end
  
  # DELETE /buttons/1
  # DELETE /buttons/1.json
  def destroy
    game_session = GameProcess.new(session[:game_session]).accept_players_button_action
    unless game_session == nil
      session[:game_session] = game_session
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
