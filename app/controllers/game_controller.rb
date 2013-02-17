class GameController < ApplicationController
  
  def index
    if Card.all == []
      pupulate_db_with_cards
    end
    if Cardholder.all == []
      populate_db_with_cardholders
    end
    redirect_to :controller => "cards", :action => "index"
  end
  
  private
  
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
