class Card < ActiveRecord::Base
  attr_accessible :image, :rank, :suit
  has_many :game_logs
  has_many :cardholders, :through => :game_logs
  has_many :games, :through => :game_logs
  
end
