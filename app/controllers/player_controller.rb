class PlayerController < ApplicationController
  respond_to :json
  # GET /player
  # GET /player.json
  def index
    game_id = Game.game_id(session[:game_session]).first.id
    player_id = Cardholder.player.first.id
    card_logs = GameLog.card_ids_for(game_id, player_id)
    @player_cards = []
    card_logs.each do |log|
      @player_cards << Card.find(log.card_id)
    end
    
    respond_to do |format|
      format.html
      format.json { respond_with @player_cards }
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    card = Card.find(params[:id])
    game = Game.where(:game_session => session[:game_session]).first
    player = Cardholder.player.first
    game_log = GameLog.where(:game_id => game.id, :cardholder_id => player.id, :card_id => card.id).first
    table = Cardholder.table.first
    positions = GameLog.select("position").where(:game_id => game.id, :cardholder_id => table.id)
    max_position = positions.to_a.max ? positions.to_a.max : 1
    game_log.update_attributes(:cardholder_id => table.id, :played_by => player.id, :position => max_position)
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end




  # GET /decks/1
  # GET /decks/1.json
  def show
    @deck = Deck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deck }
    end
  end

  # GET /decks/new
  # GET /decks/new.json
  def new
    @deck = Deck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deck }
    end
  end

  # GET /decks/1/edit
  def edit
    @deck = Deck.find(params[:id])
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = Deck.new(params[:deck])

    respond_to do |format|
      if @deck.save
        format.html { redirect_to @deck, notice: 'Deck was successfully created.' }
        format.json { render json: @deck, status: :created, location: @deck }
      else
        format.html { render action: "new" }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /decks/1
  # PUT /decks/1.json
  def update
    @deck = Deck.find(params[:id])

    respond_to do |format|
      if @deck.update_attributes(params[:deck])
        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

end
