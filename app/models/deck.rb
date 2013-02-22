class Deck
  
  def self.initiate(game)
    deck = Cardholder.deck.first
    Card.all.each do |card|
      GameLog.create(:game_id => game.id, :cardholder_id => deck.id, :card_id => card.id)
    end
  end
  
  def self.shuffle(game)
    positions = 1.upto(36).to_a
    positions.shuffle!
    deck = Cardholder.deck.first
    logs = GameLog.logs_for(game.id, deck.id)
    36.times do |i|
      logs[i].update_attribute("position", positions[i])
    end
  end
  
  def self.get_trump(game)
    deck = Cardholder.deck.first
    return deck.cards.where("game_logs.game_id = #{game.id}").order("game_logs.position ASC").last
  end
  
  def self.get_cards(game)
    deck = Cardholder.deck.first
    return @cards_in_deck = deck.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
  end
  
  def self.serve_cards(game)
    player = Cardholder.player.first
    computer = Cardholder.computer.first
    cards_player_needs = get_number_of_cards_needed_by(game, player)
    cards_computer_needs = get_number_of_cards_needed_by(game, computer)
    serve_cards_for(game, player, cards_player_needs)
    serve_cards_for(game, computer, cards_computer_needs)
  end
  
  private
  
  def self.get_number_of_cards_needed_by(game, card_holder)
    present_cards_number = card_holder.game_logs.where(:game_id => game.id).count
    number_of_cards_needed = 6 - present_cards_number
    return number_of_cards_needed >= 0 ? number_of_cards_needed : 0
  end
  
  def self.serve_cards_for(game, card_holder, number_of_cards)
    unless number_of_cards == 0
      deck = Cardholder.deck.first
      deck_logs = GameLog.logs_for(game.id, deck.id).limit(number_of_cards)
      positions = card_holder.game_logs.where(:game_id => game.id)
      positions.collect! {|log| log.position}
      max_position = positions.max ? positions.max + 1 : 1
      number_of_cards.times do |i|
        deck_logs[i].update_attributes(:cardholder_id => card_holder.id, :position => max_position + i)
      end
    end
  end
  
end
