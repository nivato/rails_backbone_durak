class DefenderController < ApplicationController
  respond_to :json
  # GET /defender
  # GET /defender.json
  def index
    game = Game.for_session(session[:game_session]).first
    table = Cardholder.table.first
    @defender_cards = table.cards.select("cards.rank, cards.suit, game_logs.position").where("game_logs.game_id = #{game.id}").where("game_logs.played_by = #{game.defender}").order("game_logs.position ASC")

    respond_to do |format|
      format.html
      format.json { respond_with @defender_cards }
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

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to decks_url }
      format.json { head :no_content }
    end
  end
end
