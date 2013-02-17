class Cardholder < ActiveRecord::Base
  attr_accessible :ch_type
  has_many :game_logs
  has_many :games, :through => :game_logs
  has_many :cards, :through => :game_logs
  
end
