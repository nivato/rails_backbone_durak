class Computer
  def self.get_cards(game)
    computer = Cardholder.computer.first
    return computer.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
  end
end
