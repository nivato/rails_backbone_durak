class GameController < ApplicationController
  respond_to :json, :html
  before_filter :setup_game_session
  # GET /game
  # GET /game.json
  def index
    respond_with GameProcess.new(session[:game_session]).get_message
  end
  
  # GET /games/1
  # GET /games/1.json
  def show
    respond_with []
  end

  # GET /games/new
  # GET /games/new.json
  def new
    respond_with []
  end

  # GET /games/1/edit
  def edit
    respond_with []
  end

  # POST /games
  # POST /games.json
  def create
    respond_with []
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    respond_with []
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    respond_with []
  end
  
  private
  
  def setup_game_session
    unless session[:game_session]
      session[:game_session] = GameProcess.new(nil).set_up_game
    end
  end
  
end
