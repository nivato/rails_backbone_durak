RailsBackboneDurak.Views.Game ||= {}

class RailsBackboneDurak.Views.Game.IndexView extends Backbone.View
  constructor: () ->
    super
  
  template: JST["backbone/templates/game/index"]
  
  addAll: () =>
    deck_view = new RailsBackboneDurak.Views.DeckCards.View(deckCards: @options.deck_cards)
    player_view = new RailsBackboneDurak.Views.PlayerCards.View(playerCards: @options.player_cards)
    @$("#deck-cards").append(deck_view.render().el)
    @$("#player-cards").append(player_view.render().el)

  render: =>
    $(@el).html(@template)
    @addAll()
    return this