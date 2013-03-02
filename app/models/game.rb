class Game < ActiveRecord::Base
  attr_accessible :game_session, :state
  
  scope :for_session, lambda{|game_session| where(:game_session => game_session)}
  
end
