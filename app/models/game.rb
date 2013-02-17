class Game < ActiveRecord::Base
  attr_accessible :game_session
  has_many :game_logs
  has_many :cardholders, :through => :game_logs
  
end
