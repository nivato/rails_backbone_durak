class GameController < ApplicationController
  respond_to :json, :html
  before_filter :setup_game_session
  
  def index
    game = Game.for_session(session[:game_session]).first
    respond_with Deck.get_trump(game)
  end
  
  private
  
  def setup_game_session
    pupulate_db
    unless session[:game_session]
      game_session = Digest::SHA2.hexdigest("#{Time.now}")
      session[:game_session] = game_session
      game = Game.create(:game_session => game_session)
      Deck.initiate(game)
      Deck.shuffle(game)
      game.update_attribute("trump", Deck.get_trump(game).id)
      Deck.serve_cards(game)
      game.update_attribute("attacker", Cardholder.player.first.id)
      game.update_attribute("defender", Cardholder.computer.first.id)
      game.update_attribute("defender_state", "continues")
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
