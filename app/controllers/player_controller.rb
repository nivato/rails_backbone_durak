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
    computer_cards = computer.cards.where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
    # attacker_card_to_beat = table.cards.where("game_logs.game_id = #{game.id}").where("game_logs.played_by = #{game.attacker}").where("game_logs.beated_with is null").first
    attacker_card_to_beat = card
    trump = Card.find(game.trump)
    card_to_beat_with = choose_card_to_beat_with(attacker_card_to_beat, computer_cards, trump)
    if card_to_beat_with != nil
      c_game_log = computer.game_logs.where(:game_id => game.id, :card_id => card_to_beat_with.id).first
      c_game_log.update_attributes(:cardholder_id => table.id, :played_by => computer.id, :position => max_position)
      game_log.update_attribute("beated_with", card_to_beat_with.id)
    end
    
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
  
  private
  
  def choose_card_to_beat_with(attacker_card_to_beat, computer_cards, trump)
    card_to_beat_with = nil
    if attacker_card_to_beat.suit_char == trump.suit_char
      card_to_beat_with = choose_higher_card_of_same_suit(attacker_card_to_beat, computer_cards)
    else
      card_to_beat_with = choose_higher_card_or_trump(attacker_card_to_beat, computer_cards, trump)
    end
    logger.info("CARD TO BEAT WITH #{card_to_beat_with.inspect}")
    return card_to_beat_with
  end
  
  def choose_higher_card_or_trump(attacker_card_to_beat, computer_cards, trump)
    card_to_beat_with = choose_higher_card_of_same_suit(attacker_card_to_beat, computer_cards)
    unless card_to_beat_with
      cards_of_trump_suit = computer_cards.collect do |card|
        card if card.suit_char == trump.suit_char
      end
      cards_of_trump_suit.compact!
      unless cards_of_trump_suit == []
        ranks = cards_of_trump_suit.collect do |card|
          card.rank_number
        end
        min_rank = ranks.to_a.min
        cards_of_trump_suit.each do |card|
          card_to_beat_with = card if card.rank_number == min_rank
        end
      end
    end
    return card_to_beat_with
  end
    
  def choose_higher_card_of_same_suit(attacker_card_to_beat, computer_cards)
    card_to_beat_with = nil
    cards_of_same_suit = computer_cards.collect do |card|
        card if card.suit_char == attacker_card_to_beat.suit_char
    end
    cards_of_same_suit.compact!
    unless cards_of_same_suit == []
      cards_of_higher_rank = cards_of_same_suit.collect do |card|
        card if card.rank_number > attacker_card_to_beat.rank_number
      end
      cards_of_higher_rank.compact!
      unless cards_of_higher_rank == []
        ranks = cards_of_higher_rank.collect do |card|
          card.rank_number
        end
        min_rank = ranks.to_a.min
        cards_of_higher_rank.each do |card|
          card_to_beat_with = card if card.rank_number == min_rank
        end
      end
    end
    return card_to_beat_with
  end

end
