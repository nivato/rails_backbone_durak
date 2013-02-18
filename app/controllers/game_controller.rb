class GameController < ApplicationController
  respond_to :json
  before_filter :setup_game_session
  
  def index
    pupulate_db
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  private
  
  def setup_game_session
    unless session[:game_session]
      game_session = Digest::SHA2.hexdigest("#{Time.now}")
      session[:game_session] = game_session
      game = Game.create(:game_session => game_session)
      deck = Cardholder.deck.first
      Card.all.each do |card|
        GameLog.create(:game_id => game.id, :cardholder_id => deck.id, :card_id => card.id)
      end
      shuffle_deck(game)
      serve_cards_a_player(6, game.id)
    end
  end
  
  def serve_cards_a_player(number_of_cards, game_id)
    deck = Cardholder.deck.first
    player = Cardholder.player.first
    deck_logs = GameLog.logs_for(game_id, deck.id).limit(number_of_cards)
    deck_logs.each do |log|
      log.update_attribute("cardholder_id", player.id)
    end
  end
  
  def shuffle_deck(game)
    positions = 1.upto(36).to_a
    positions.shuffle!
    deck = Cardholder.deck.first
    logs = GameLog.logs_for(game.id, deck.id)
    36.times do |i|
      logs[i].update_attribute("position", positions[i])
    end
  end
  
  def pupulate_db
    if Card.all == []
      pupulate_db_with_cards
    end
    if Cardholder.all == []
      populate_db_with_cardholders
    end
  end
  
  def pupulate_db_with_cards
    ranks = ["6", "7", "8", "9", "10", "J", "Q", "K", "A"]
      suits = [
        "\u2660", #spades
        "\u2665", #hearts
        "\u2666", #diamonds
        "\u2663", #clubs
      ]
      ranks.each do |rank|
        suits.each do |suit|
          card = Card.new
          card.rank = rank
          card.suit = suit
          card.save
        end
      end
  end
  
  def populate_db_with_cardholders
    ch_types = ["Player", "Computer", "Deck", "Table", "Pile"]
      ch_types.each do |ch_type|
        cardholder = Cardholder.new
        cardholder.ch_type = ch_type
        cardholder.save
      end
  end
  
end