class Card < ActiveRecord::Base
  attr_accessible :image, :rank, :suit
end
