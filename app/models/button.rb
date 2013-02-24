class Button
  def self.get_buttons(game)
    table_cards = Table.get_cards(game)
    buttons = {}
    if (game.players_turn? && (table_cards != [])) || (game.computers_turn? && (game.defender_state == "won"))
      buttons["next"] = true
    else
      buttons["next"] = false
    end
    if game.computers_turn? && ((game.defender_state == "continues") || (game.defender_state == "defeated")) && (table_cards != [])
      buttons["take_cards"] = true
    else
      buttons["take_cards"] = false
    end
    if ((Computer.get_cards(game) == []) || (Player.get_cards(game) == [])) && Deck.get_cards(game) == []
      buttons["new_game"] = true
      buttons["next"] = false
      buttons["take_cards"] = false
      game.update_attribute("finished", true)
    else
      buttons["new_game"] = false
    end
    buttons["id"] = 1
    return buttons
  end
end
