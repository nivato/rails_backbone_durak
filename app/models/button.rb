class Button
  def self.get_buttons(game)
    player = Cardholder.player.first
    computer = Cardholder.computer.first
    table_cards = Table.get_cards(game)
    buttons = {}
    if ((game.attacker == player.id) && (table_cards != [])) || ((game.attacker == computer.id) && (game.defender_state == "won"))
      buttons["next"] = true
    else
      buttons["next"] = false
    end
    if (game.attacker == computer.id) && ((game.defender_state == "continues") || (game.defender_state == "defeated")) && (table_cards != [])
      buttons["take_cards"] = true
    else
      buttons["take_cards"] = false
    end
    buttons["id"] = 1
    return buttons
  end
end
