RailsBackboneDurak.Views.Game ||= {}

class RailsBackboneDurak.Views.Game.IndexView extends Backbone.View
  constructor: () ->
    super
  
  template: JST["backbone/templates/game/index"]

  addAll: () =>
    deck_view = new RailsBackboneDurak.Views.DeckCards.View(deckCards: @options.deck_cards)
    @$("#deck-cards").append(deck_view.render().el)

  render: =>
    $(@el).html(@template)
    @addAll()
    return this
