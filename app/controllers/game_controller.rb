class GameController < ApplicationController
  respond_to :json, :html
  before_filter :setup_game_session
  
  def index
    game = Game.for_session(session[:game_session]).first
    @trump = Card.find(game.trump)
    respond_with @trump
  end
  
  private
  
  def setup_game_session
    pupulate_db
    unless session[:game_session]
      game_session = Digest::SHA2.hexdigest("#{Time.now}")
      session[:game_session] = game_session
      game = Game.create(:game_session => game_session)
      deck = Cardholder.deck.first
      Card.all.each do |card|
        GameLog.create(:game_id => game.id, :cardholder_id => deck.id, :card_id => card.id)
      end
      shuffle_deck(game)
      trump = deck.cards.where("game_logs.game_id = #{game.id}").order("game_logs.position ASC").last
      game.update_attribute("trump", trump.id)
      serve_cards(6, game.id, Cardholder.player.first.id)
      serve_cards(6, game.id, Cardholder.computer.first.id)
      game.update_attribute("attacker", Cardholder.player.first.id)
      game.update_attribute("defender", Cardholder.computer.first.id)
    end
  end
  
  def serve_cards(number_of_cards, game_id, holder_id)
    deck = Cardholder.deck.first
    deck_logs = GameLog.logs_for(game_id, deck.id).limit(number_of_cards)
    number_of_cards.times do |i|
      deck_logs[i].update_attributes(:cardholder_id => holder_id, :position => i)
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
    ranks = {
      6 => "6", 
      7 => "7", 
      8 => "8", 
      9 => "9", 
      10 => "10", 
      11 => "J", 
      12 => "Q", 
      13 => "K", 
      14 => "A"
    }
    suits = {
      "s" => "\u2660", #spades
      "h" => "\u2665", #hearts
      "d" => "\u2666", #diamonds
      "c" => "\u2663", #clubs
    }
    ranks.each do |rank_number, rank|
      suits.each do |suit_char, suit|
        card = Card.new
        card.rank = rank
        card.rank_number = rank_number
        card.suit = suit
        card.suit_char = suit_char
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
