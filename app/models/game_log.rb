class GameLog < ActiveRecord::Base
  attr_accessible :game_id, :cardholder_id, :card_id
  belongs_to :game
  belongs_to :cardholder
  belongs_to :card
end
