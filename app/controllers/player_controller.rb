class PlayerController < ApplicationController
  respond_to :json
  # GET /player
  # GET /player.json
  def index
    game = Game.for_session(session[:game_session]).first
    player = Cardholder.player.first
    @player_cards = player.cards.select("cards.id, cards.rank, cards.suit, game_logs.position").where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
    
    table = Cardholder.table.first
    table_cards = table.cards.where("game_logs.game_id = #{game.id}")
    
    if table_cards == []
      @player_cards.each do |card|
        card["playable"] = true
      end
    else
      table_ranks = table_cards.collect{|card| card.rank}
      @player_cards.each do |card|
        if table_ranks.include? card.rank
          card["playable"] = true
        else
          card["playable"] = false
        end
      end
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
    game = Game.for_session(session[:game_session]).first
    player = Cardholder.player.first
    game_log = player.game_logs.where(:game_id => game.id, :card_id => card.id).first
    table = Cardholder.table.first
    positions = table.game_logs.select("position").where(:game_id => game.id, :played_by => game.attacker)
    max_position = positions.to_a.max ? positions.to_a.max.position + 1 : 1
    game_log.update_attributes(:cardholder_id => table.id, :played_by => player.id, :position => max_position)
    
    # make computer to choose card to beat with
    computer = Cardholder.computer.first
    #computer_cards = computer.cards.where(:game_id => game.id).order("game_logs.position ASC")
    #attacker_card_to_beat = table.cards.where("game_logs.game_id = #{game.id}").where("game_logs.played_by = #{game.attacker}").where("game_logs.beated_with is null")
    c_game_log = computer.game_logs.where(:game_id => game.id).order("game_logs.position ASC").first
    c_card = Card.find(c_game_log.card_id)
    c_game_log.update_attributes(:cardholder_id => table.id, :played_by => computer.id, :position => max_position)
    game_log.update_attribute("beated_with", c_card.id)
    
    
    
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
