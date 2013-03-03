class Game < ActiveRecord::Base
  attr_accessible :game_session, :player_cards, :computer_cards, :deck_cards, :attacker_cards, :defender_cards, :trump, :attacker, :defender_state, :game_finished, :message
  
  scope :for_session, lambda{|game_session| where(:game_session => game_session)}
  
end
