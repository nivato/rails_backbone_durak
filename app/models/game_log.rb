class GameLog < ActiveRecord::Base
  attr_accessible :game_id, :cardholder_id, :card_id
  belongs_to :game
  belongs_to :cardholder
  belongs_to :card
  
  scope :card_ids_for, lambda {|game_id, cardholder_id| select("card_id").where(:game_id => game_id, :cardholder_id => cardholder_id)}
end
