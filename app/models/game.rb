class Game < ActiveRecord::Base
  attr_accessible :game_session, :attacker, :defender_state, :defender, :trump
  has_many :game_logs
  has_many :cardholders, :through => :game_logs
  has_many :cards, :through => :game_logs
  
  scope :for_session, lambda{|game_session| where(:game_session => game_session)}
end
