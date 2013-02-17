class Cardholder < ActiveRecord::Base
  attr_accessible :ch_type
  has_many :game_logs
  has_many :games, :through => :game_logs
  has_many :cards, :through => :game_logs
  
  scope :player, where(:ch_type => "Player")
  scope :deck, where(:ch_type => "Deck")
  scope :table, where(:ch_type => "Table")
  scope :computer, where(:ch_type => "Computer")
  scope :pile, where(:ch_type => "Pile")
end
