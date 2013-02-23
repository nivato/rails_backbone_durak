class Pile
  def self.get_cards(game)
    pile = Cardholder.pile.first
    return pile.cards.select("cards.*, game_logs.position").where("game_logs.game_id = #{game.id}").order("game_logs.position ASC")
  end
end
