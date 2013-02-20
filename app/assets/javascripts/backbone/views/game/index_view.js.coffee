RailsBackboneDurak.Views.Game ||= {}

class RailsBackboneDurak.Views.Game.IndexView extends Backbone.View
  constructor: () ->
    super
  
  template: JST["backbone/templates/game/index"]
  
  addAll: () =>
    deck_view = new RailsBackboneDurak.Views.DeckCards.View(deckCards: @options.deck_cards)
    player_view = new RailsBackboneDurak.Views.PlayerCards.View(eventer: @options.eventer, playerCards: @options.player_cards)
    computer_view = new RailsBackboneDurak.Views.ComputerCards.View(eventer: @options.eventer, computerCards: @options.computer_cards)
    table_view = new RailsBackboneDurak.Views.Table.TableView(eventer: @options.eventer, attacker_cards: @options.attacker_cards, defender_cards: @options.defender_cards)
    @$("#deck-cards").append(deck_view.render().el)
    @$("#player-cards").append(player_view.render().el)
    @$("#computer-cards").append(computer_view.render().el)
    @$("#table-cards").append(table_view.render().el)

  render: =>
    $(@el).html(@template)
    @addAll()
    return this
